# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require 'spec_helper'

RSpec.describe Realize::Collection::Last do
  let(:resolver) { Objectable.resolver }

  let(:first_object) do
    {
      id: 1,
      name: 'apple'
    }
  end

  let(:second_object) do
    {
      id: 2,
      name: 'orange'
    }
  end

  let(:third_object) do
    {
      id: 3,
      name: 'banana'
    }
  end

  let(:value) { [first_object, second_object, third_object] }

  subject { described_class.new }

  describe '#transform' do
    context 'last' do
      it 'when value is an array' do
        expect(subject.transform(resolver, value, nil, nil)).to eq(third_object)
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
