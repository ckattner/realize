# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require 'spec_helper'

RSpec.describe Realize::Format::RemoveWhitespace do
  let(:resolver) { nil }
  let(:time)     { nil }

  subject { described_class.new }

  describe '#transform' do
    it 'replaces \n with a space' do
      value     = "500 Sunflower Ave\nUnit 1"
      expected  = '500 Sunflower Ave Unit 1'

      expect(subject.transform(resolver, value, time, nil)).to eq(expected)
    end

    it 'replaces \r\n with a space' do
      value     = "500 Sunflower Ave\r\nUnit 1"
      expected  = '500 Sunflower Ave Unit 1'

      expect(subject.transform(resolver, value, time, nil)).to eq(expected)
    end

    it 'replaces a combination of whitespace characters with a space' do
      value     = "500\rSunflower\nAve\r\nUnit\t1"
      expected  = '500 Sunflower Ave Unit 1'

      expect(subject.transform(resolver, value, time, nil)).to eq(expected)
    end
  end
end
