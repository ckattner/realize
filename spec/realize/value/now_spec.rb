# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Realize::Value::Now do
  let(:record)     { {} }
  let(:resolver)   { nil }
  let(:time)       { nil }

  subject { described_class.make(utc_offset: utc_offset) }

  describe '#transform' do
    context 'without a custom utc_offset' do
      let(:utc_offset) { nil }

      it 'returns proper offset' do
        time = subject.transform(resolver, nil, time, record)

        utc_offset_in_seconds = 0

        expect(time.utc_offset).to eq(utc_offset_in_seconds)
      end
    end

    context 'with a custom utc_offset' do
      let(:utc_offset) { '+02:30' }

      it 'should return a Time instance' do
        time = subject.transform(resolver, nil, time, record)

        expect(time).to be_a(Time)
      end

      it 'returns proper offset' do
        time = subject.transform(resolver, nil, time, record)

        utc_offset_in_seconds = 2.5 * 60 * 60

        expect(time.utc_offset).to eq(utc_offset_in_seconds)
      end

      it 'returns a time object within normal limits' do
        lower_limit = Time.now.utc

        time = subject.transform(resolver, nil, time, record)

        upper_limit = Time.now.utc.localtime(utc_offset)

        expect(time).to be >= lower_limit
        expect(time).to be <= upper_limit
      end
    end
  end
end
