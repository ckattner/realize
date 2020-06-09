# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Realize::Filter::ByKeyRecordValue do
  let(:resolver) { Objectable.resolver }
  let(:time)     { nil }
  let(:key)      { 'id' }
  let(:value)    { 'lookup_id' }

  let(:record) do
    [
      { "id": 11 },
      { "id": 12 },
      { "1d": 13 }
    ]
  end

  let(:original_record) do
    {
      "lookup_id": 12,
      "ids": record
    }
  end

  subject { described_class.new(key: key, value: value) }

  describe '#transform' do
    context 'original record matching' do
      it 'matches on record with original record value as key' do
        expected = [{ "id": 12 }]

        expect(subject.transform(resolver, record, time, original_record)).to eq(expected)
      end
      it 'returns empty array when not found in record' do
        expected = []

        missing_id_original_record = {
          "lookup_id": 200,
          "ids": record
        }

        expect(
          subject.transform(
            resolver,
            record,
            time,
            missing_id_original_record
          )
        ).to eq(expected)
      end
    end
  end
end
