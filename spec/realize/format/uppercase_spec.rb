# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require 'spec_helper'

RSpec.describe Realize::Format::Uppercase do
  let(:record)     { {} }
  let(:resolver)   { nil }
  let(:time)       { nil }

  subject { described_class.new }

  describe '#transform' do
    it 'returns an uppercase string' do
      %w[abc dEf GHI 123].each do |value|
        actual = subject.transform(resolver, value, time, record)

        expect(actual).to eq(value.to_s.upcase)
      end
    end
  end
end
