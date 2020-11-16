# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require 'spec_helper'

RSpec.describe Realize::Value::Uuid do
  let(:record)     { {} }
  let(:resolver)   { nil }
  let(:time)       { nil }

  describe '#transform' do
    it 'returns a string with a length of 36' do
      value = subject.transform(resolver, nil, time, record)

      expect(value.length).to eq(36)
    end

    it 'returns a unique string' do
      count = 30
      ids   = Set.new

      (0...count).each { ids << subject.transform(resolver, nil, time, record) }

      expect(ids.length).to eq(count)
    end
  end
end
