# frozen_string_literal: true

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
