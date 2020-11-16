# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require 'spec_helper'

RSpec.describe Realize::Value::Verbatim do
  let(:record)   { {} }
  let(:resolver) { nil }
  let(:time)     { nil }

  describe '#transform' do
    it 'should return input' do
      value = 12_345.67

      expect(subject.transform(resolver, value, time, record)).to eq(value)
    end
  end
end
