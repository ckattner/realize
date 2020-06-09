# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Realize::Value::Static do
  let(:record)   { {} }
  let(:resolver) { nil }
  let(:time)     { nil }
  let(:value)    { 'something' }

  subject { described_class.new(value: value) }

  describe '#transform' do
    it 'should return input' do
      expect(subject.transform(resolver, value, time, record)).to eq('something')
    end
  end
end
