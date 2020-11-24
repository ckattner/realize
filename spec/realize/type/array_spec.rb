# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require 'spec_helper'

RSpec.describe Realize::Type::Array do
  let(:record)     { {} }
  let(:resolver)   { nil }
  let(:time)       { nil }

  subject { described_class.make(nullable: nullable) }

  describe '#transform' do
    context 'nullable' do
      let(:nullable) { true }

      it 'returns nil if nil is passed in' do
        actual = subject.transform(resolver, nil, time, record)

        expect(actual).to be nil
      end

      it 'returns an array if anything not nil is passed in' do
        [23.45, false, true, {}, []].each do |value|
          actual = subject.transform(resolver, value, time, record)

          expect(actual).to be_a(Array)
        end
      end
    end
  end

  context 'not nullable' do
    let(:nullable) { false }

    it 'always returns an array' do
      [nil, 23.45, false, true, {}, []].each do |value|
        actual = subject.transform(resolver, value, time, record)

        expect(actual).to be_a(Array)
      end
    end

    context 'when value is a hash' do
      let(:value) { { a: 1 } }

      it 'returns an array with the hash as an element' do
        actual = subject.transform(resolver, value, time, record)

        expect(actual).to eq([value])
      end
    end
  end
end
