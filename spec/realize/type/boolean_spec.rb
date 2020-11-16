# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require 'spec_helper'

TEST_CASES = [
  [nil, false],
  [true, true],
  ['t', true],
  ['true', true],
  ['TRUE', true],
  ['True', true],
  ['1', true],
  ['Y', true],
  ['y', true],
  ['yes', true],
  ['YES', true],
  ['Yes', true],
  [false, false],
  ['f', false],
  ['false', false],
  ['FALSE', false],
  ['False', false],
  ['0', false],
  ['N', false],
  ['n', false],
  ['no', false],
  ['NO', false],
  ['No', false],
  ['', false],
  [{}, false]
].freeze

RSpec.describe Realize::Type::Boolean do
  let(:record)     { {} }
  let(:resolver)   { nil }
  let(:time)       { nil }

  subject { described_class.make(nullable: nullable) }

  describe '#transform' do
    context 'nullable' do
      let(:nullable) { true }

      it 'returns nil when nil is passed in' do
        actual = subject.transform(resolver, nil, time, record)

        expect(actual).to be nil
      end
    end

    context 'not nullable' do
      let(:nullable) { false }

      TEST_CASES.each do |test_case|
        input_value    = test_case[0]
        expected_value = test_case[1]

        it "#{input_value} should return #{expected_value}" do
          actual = subject.transform(resolver, input_value, time, record)

          expect(actual).to eq(expected_value)
        end
      end
    end
  end
end
