# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Realize::Pipeline do
  let(:time) { Time.parse('2019-01-10 2:00:00 PM UTC') }

  let(:record) do
    {
      name: 'Frank Rizzo'
    }
  end

  let(:transformers) do
    [
      {
        type: 'r/value/resolve',
        key: :name
      }
    ]
  end

  subject { described_class.new(transformers) }

  describe '#transform' do
    it 'executes transformers and returns last value' do
      actual = subject.transform(record, time)

      expect(actual).to eq('Frank Rizzo')
    end
  end
end
