# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Realize::Value::Map do
  let(:resolver) { Objectable.resolver }
  let(:time)     { Time.parse('2019-01-10 2:00:00 PM UTC') }

  let(:values) do
    {
      '1' => 'STRING1',
      1 => 'NUMBER1',
      :'1' => 'SYMBOL1',
      nil => 'NIL',
      'aaa' => 'LOWERCASE',
      'AAA' => 'UPPERCASE'
    }
  end

  subject { described_class.new(values: values) }

  describe '#transform' do
    context 'case-sensitivity' do
      it 'matches lowercase string' do
        value     = 'aaa'
        expected  = 'LOWERCASE'

        expect(subject.transform(resolver, value, time, values)).to eq(expected)
      end

      it 'matches uppercase string' do
        value     = 'AAA'
        expected  = 'UPPERCASE'

        expect(subject.transform(resolver, value, time, values)).to eq(expected)
      end

      it 'does not match missing cased value' do
        value     = 'aAa'
        expected  = 'aAa'

        expect(subject.transform(resolver, value, time, values)).to eq(expected)
      end
    end

    context 'type-sensitivity' do
      it 'matches String key' do
        value     = '1'
        expected  = 'STRING1'

        expect(subject.transform(resolver, value, time, values)).to eq(expected)
      end

      it 'matches FixNum key' do
        value     = 1
        expected  = 'NUMBER1'

        expect(subject.transform(resolver, value, time, values)).to eq(expected)
      end

      it 'matches Symbol key' do
        value     = :'1'
        expected  = 'SYMBOL1'

        expect(subject.transform(resolver, value, time, values)).to eq(expected)
      end

      it 'matches nil key' do
        value     = nil
        expected  = 'NIL'

        expect(subject.transform(resolver, value, time, values)).to eq(expected)
      end
    end
  end
end
