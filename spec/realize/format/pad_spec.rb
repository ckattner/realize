# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require 'spec_helper'

RSpec.describe Realize::Format::Pad do
  let(:record)     { {} }
  let(:resolver)   { nil }
  let(:time)       { nil }
  let(:with)       { '123' }

  subject { described_class.new(length: length, side: side, with: with) }

  describe '#transform' do
    context 'length is null' do
      let(:side)   { :left }
      let(:length) { nil }

      it 'does no padding' do
        value  = 'ABC'
        actual = subject.transform(resolver, value, time, record)

        expect(actual).to eq(value)
      end
    end

    context 'length is less than the value length' do
      let(:side)   { :left }
      let(:length) { 2 }

      it 'does no padding' do
        value  = 'ABC'
        actual = subject.transform(resolver, value, time, record)

        expect(actual).to eq(value)
      end
    end

    context 'length is greater than the value length' do
      let(:length) { 10 }

      context 'left side' do
        let(:side) { :left }

        it 'returns padded string' do
          value    = 'ABC'
          expected = '1231231ABC'
          actual   = subject.transform(resolver, value, time, record)

          expect(actual).to eq(expected)
        end
      end

      context 'right side' do
        let(:side) { :right }

        it 'returns padded string' do
          value    = 'ABC'
          expected = 'ABC1231231'
          actual   = subject.transform(resolver, value, time, record)

          expect(actual).to eq(expected)
        end
      end
    end
  end
end
