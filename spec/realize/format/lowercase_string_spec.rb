# frozen_string_literal: true

require 'spec_helper'

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

RSpec.describe Realize::Format::Lowercase do
  let(:record)     { {} }
  let(:resolver)   { nil }
  let(:time)       { nil }

  subject { described_class.new }

  describe '#transform' do
    it 'returns a lowercase string' do
      %w[abc dEf GHI 123].each do |value|
        actual = subject.transform(resolver, value, time, record)

        expect(actual).to eq(value.to_s.downcase)
      end
    end
  end
end
