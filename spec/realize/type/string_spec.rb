# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Realize::Type::String do
  let(:record)     { {} }
  let(:resolver)   { nil }
  let(:time)       { nil }

  subject { described_class.make(nullable: nullable) }

  describe '#transform' do
    context 'nullable' do
      let(:nullable) { true }

      it 'returns nil if nil is passed in' do
        actual = subject.transform(resolver, nil, time, record)

        expect(actual).to be nil
      end

      it 'returns a string if anything not nil is passed in' do
        [23.45, false, true, Time.now, {}, []].each do |value|
          actual = subject.transform(resolver, value, time, record)

          expect(actual).to be_a(String)
        end
      end
    end
  end

  context 'not nullable' do
    let(:nullable) { false }

    it 'returns a string' do
      [nil, 23.45, false, true, Time.now, {}, []].each do |value|
        actual = subject.transform(resolver, value, time, record)

        expect(actual).to be_a(String)
      end
    end
  end
end
