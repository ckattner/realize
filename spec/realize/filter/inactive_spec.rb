# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Realize::Filter::Inactive do
  let(:resolver) { Objectable.resolver }
  let(:time)     { Time.parse('2019-01-10 2:00:00 PM UTC') }

  subject { described_class.new(start_date_key: 'startDate', end_date_key: 'endDate') }

  let(:past_inactive_record) do
    {
      id: :past_inactive_record,
      'startDate' => Time.parse('2019-01-10 1:59:56 PM UTC'),
      'endDate' => Time.parse('2019-01-10 1:59:58 PM UTC')
    }
  end

  let(:active_record) do
    {
      id: :active_record,
      'startDate' => Time.parse('2019-01-10 1:59:59 PM UTC'),
      'endDate' => Time.parse('2019-01-10 2:00:01 PM UTC')
    }
  end

  let(:future_inactive_record) do
    {
      id: :future_inactive_record,
      'startDate' => Time.parse('2019-01-10 2:00:01 PM UTC'),
      'endDate' => Time.parse('2019-01-10 2:00:03 PM UTC')
    }
  end

  describe '#transform' do
    context 'with records with both a start and end date' do
      it 'should return input' do
        records = [
          past_inactive_record,
          active_record,
          future_inactive_record
        ]

        expected = [active_record]

        expect(subject.transform(resolver, records, time, records)).to eq(expected)
      end
    end
  end
end
