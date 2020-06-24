# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Realize::Collection::First do
  let(:resolver) { Objectable.resolver }

  let(:first_object) do
    {
      'id': 1,
      'name': 'apple'
    }
  end

  let(:second_object) do
    {
      'id': 2,
      'name': 'orange'
    }
  end

  let(:third_object) do
    {
      'id': 3,
      'name': 'banana'
    }
  end

  let(:value) { [first_object, second_object, third_object] }

  subject { described_class.new }

  describe '#transform' do
    context 'first' do
      it 'when value is an array' do
        expect(subject.transform(resolver, value, nil, nil)).to eq(first_object)
      end
      it 'when value is not an array' do
        expect(subject.transform(resolver, first_object, nil, nil))
          .to eq(first_object)
      end
      it 'returns nil for an empty array' do
        expect(subject.transform(resolver, [], nil, nil)).to eq(nil)
      end
    end
  end
end
