# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Realize::Transformers do
  describe '#make' do
    it 'makes transformers with no arguments' do
      transformer = { type: 'r/value/blank' }

      expect { described_class.make(transformer) }.not_to raise_error
    end
  end
end
