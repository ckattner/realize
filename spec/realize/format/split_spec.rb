# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require 'spec_helper'

RSpec.describe Realize::Format::Split do
  let(:record)     { {} }
  let(:resolver)   { nil }
  let(:time)       { nil }
  let(:by)         { ' ' }

  subject { described_class.new(by: by) }

  describe '#transform' do
    it 'returns array of values' do
      value    = 'value1 value2 value3'
      expected = %w[value1 value2 value3]
      actual   = subject.transform(resolver, value, time, record)

      expect(actual).to eq(expected)
    end
  end
end
