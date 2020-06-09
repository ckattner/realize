# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Realize::Format::StringReplace do
  let(:record)   { nil }
  let(:resolver) { nil }
  let(:time)     { nil }

  describe '#transform' do
    it 'replaces all instances of a character with a replacement' do
      subject = described_class.new(original: 't', replacement: 'b')
      value = 'tall tots'
      expected = 'ball bobs'

      expect(subject.transform(resolver, value, time, record)).to eq(expected)
    end

    it 'replaces a combination of characters with a replacement' do
      subject = described_class.new(original: 'tall', replacement: 'a')
      value = 'tall'
      expected = 'a'

      expect(subject.transform(resolver, value, time, record)).to eq(expected)
    end

    it 'replaces a newline character with a replacement' do
      subject = described_class.new(original: "\n", replacement: ' ')
      value = "123\nstreet"
      expected = '123 street'

      expect(subject.transform(resolver, value, time, record)).to eq(expected)
    end

    it 'replaces a character with an empty string' do
      subject = described_class.new(original: 'n', replacement: '')
      value = 'mental'
      expected = 'metal'

      expect(subject.transform(resolver, value, time, record)).to eq(expected)
    end

    it 'can handle nil as a replacement' do
      subject = described_class.new(original: 'n', replacement: nil)
      value = 'mental'
      expected = 'metal'

      expect(subject.transform(resolver, value, time, record)).to eq(expected)
    end

    it 'raises an error if keywords are not given' do
      expect { described_class.new }.to raise_error(ArgumentError)
    end
  end
end
