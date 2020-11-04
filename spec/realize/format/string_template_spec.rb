# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Realize::Format::StringTemplate do
  let(:mickey_mouse) do
    {
      id: 123,
      name: {
        first: 'Mickey',
        last: 'Mouse'
      }
    }
  end

  let(:frank_rizzo) do
    {
      id: 456,
      name: {
        first: 'Frank',
        last: 'Rizzo'
      }
    }
  end

  let(:resolver)   { nil }
  let(:time)       { nil }
  let(:expression) { 'Person: {name.first} {name.last}' }
  let(:separator)  { '.' }

  subject do
    described_class.new(
      expression: expression,
      separator: separator,
      use_record: use_record
    )
  end

  describe '#transform' do
    context 'when use_record is true' do
      let(:use_record) { true }

      it 'evaluates expression against the record' do
        expected = 'Person: Mickey Mouse'

        expect(subject.transform(resolver, frank_rizzo, time, mickey_mouse)).to eq(expected)
      end
    end

    context 'when use_record is false' do
      let(:use_record) { false }

      it 'evaluates expression against the value' do
        expected = 'Person: Frank Rizzo'

        expect(subject.transform(resolver, frank_rizzo, time, mickey_mouse)).to eq(expected)
      end
    end
  end
end
