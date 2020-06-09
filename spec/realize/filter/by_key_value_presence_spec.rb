# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Realize::Filter::ByKeyValuePresence do
  let(:resolver) { Objectable.resolver }
  let(:time)     { Time.parse('2019-01-10 2:00:00 PM UTC') }
  let(:key)      { 'likes_honey_mustard' }

  subject { described_class.new(key: key) }

  describe '#transform' do
    it 'does not match record with key but null value' do
      record    = { 'likes_honey_mustard' => nil }
      expected  = []

      expect(subject.transform(resolver, record, time, record)).to eq(expected)
    end

    it 'does not match record with key but blank value' do
      record    = { 'likes_honey_mustard' => '' }
      expected  = []

      expect(subject.transform(resolver, record, time, record)).to eq(expected)
    end

    it 'does not match record with different type of key (symbol not string) but has value' do
      record    = { 'likes_honey_mustard': '' }
      expected  = []

      expect(subject.transform(resolver, record, time, record)).to eq(expected)
    end

    it 'does not match record without key' do
      record    = { 'something_else': 'abc' }
      expected  = []

      expect(subject.transform(resolver, record, time, record)).to eq(expected)
    end

    it 'matches on record with exact key and a present value' do
      record    = { 'likes_honey_mustard': 'abc' }
      expected  = [record]

      expect(subject.transform(resolver, record, time, record)).to eq(expected)
    end
  end
end
