# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require 'spec_helper'

RSpec.describe Realize::Value::Resolve do
  let(:resolver) { Objectable.resolver }
  let(:time)     { Time.parse('2019-01-10 2:00:00 PM UTC') }
  let(:key)      { 'likes_honey_mustard' }

  subject { described_class.new(key: key) }

  describe '#transform' do
    context 'when value is an array' do
      it 'selects first record for value resolution' do
        value     = 'i do!'
        record    = [{ 'likes_honey_mustard': value }]
        expected  = value

        expect(subject.transform(resolver, record, time, record)).to eq(expected)
      end
    end

    context 'when value is not an array' do
      it 'uses value as a record for value resolution' do
        value     = 'i do!'
        record    = { 'likes_honey_mustard': value }
        expected  = value

        expect(subject.transform(resolver, record, time, record)).to eq(expected)
      end
    end
  end
end
