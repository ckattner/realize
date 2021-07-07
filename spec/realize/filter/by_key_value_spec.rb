# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require 'spec_helper'

RSpec.describe Realize::Filter::ByKeyValue do
  let(:key)      { 'likes_honey_mustard' }
  let(:resolver) { Objectable.resolver }
  let(:time)     { Time.parse('2019-01-10 2:00:00 PM UTC') }
  let(:value)    { 'i do!' }

  subject { described_class.new(key: key, value: value) }

  describe '#transform' do
    context 'type-sensitivity' do
      it 'matches on record with exact key and exact value' do
        record    = { 'likes_honey_mustard' => 'i do!' }
        expected  = [record]

        expect(subject.transform(resolver, record, time, record)).to eq(expected)
      end

      it 'matches on record with different-typed key and exact value' do
        record    = { likes_HONEY_mustard: 'i do!' }
        expected  = []

        expect(subject.transform(resolver, record, time, record)).to eq(expected)
      end
    end

    context 'case-sensitivity' do
      it 'does not match on record with exact key and different-cased value' do
        record    = { likes_honey_mustard: 'i DO!' }
        expected  = []

        expect(subject.transform(resolver, record, time, record)).to eq(expected)
      end

      it 'does not match on record with different-cased key and exact value' do
        record    = { likes_HONEY_mustard: 'i do!' }
        expected  = []

        expect(subject.transform(resolver, record, time, record)).to eq(expected)
      end
    end
  end
end
