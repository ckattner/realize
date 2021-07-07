# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require 'spec_helper'

RSpec.describe Realize::Collection::Join do
  let(:resolver) { Objectable.resolver }

  let(:first_array) do
    %w[111 Bonus]
  end

  let(:second_array) do
    %w[222 Holiday Pay]
  end

  let(:third_array) do
    %w[333 Holiday Pay Bonus]
  end

  let(:not_an_array) do
    'This is not an array.'
  end

  subject { described_class.new(start_index: 1) }

  describe '#transform with start index 1' do
    context 'join' do
      it 'when two elements, one word' do
        expect(subject.transform(resolver, first_array, nil, nil)).to eq('Bonus')
      end
      it 'when three elements, two words' do
        expect(subject.transform(resolver, second_array, nil, nil)).to eq('HolidayPay')
      end
      it 'when four elements, three words' do
        expect(subject.transform(resolver, third_array, nil, nil)).to eq('HolidayPayBonus')
      end
      it 'when value is not an array' do
        expect(subject.transform(resolver, not_an_array, nil, nil))
          .to eq('')
      end
      it 'when empty array (out of range)' do
        expect(subject.transform(resolver, [], nil, nil)).to eq('')
      end
      it 'when nil' do
        expect(subject.transform(resolver, nil, nil, nil)).to eq('')
      end
    end
  end

  describe '#transform with end index 0' do
    subject { described_class.new(end_index: 0) }

    context 'join' do
      it 'when two elements, one word' do
        expect(subject.transform(resolver, first_array, nil, nil)).to eq('111')
      end
      it 'when three elements, two words' do
        expect(subject.transform(resolver, second_array, nil, nil)).to eq('222')
      end
      it 'when four elements, three words' do
        expect(subject.transform(resolver, third_array, nil, nil)).to eq('333')
      end
      it 'when value is not an array' do
        expect(subject.transform(resolver, not_an_array, nil, nil))
          .to eq('This is not an array.')
      end
      it 'when empty array (out of range)' do
        expect(subject.transform(resolver, [], nil, nil)).to eq('')
      end
      it 'when nil' do
        expect(subject.transform(resolver, nil, nil, nil)).to eq('')
      end
    end
  end

  describe '#transform no indices set' do
    subject { described_class.new }

    context 'join' do
      it 'when two elements, two words' do
        expect(subject.transform(resolver, first_array, nil, nil)).to eq('111Bonus')
      end
      it 'when three elements, three words' do
        expect(subject.transform(resolver, second_array, nil, nil)).to eq('222HolidayPay')
      end
      it 'when four elements, four words' do
        expect(subject.transform(resolver, third_array, nil, nil)).to eq('333HolidayPayBonus')
      end
      it 'when value is not an array' do
        expect(subject.transform(resolver, not_an_array, nil, nil))
          .to eq('This is not an array.')
      end
      it 'when empty array' do
        expect(subject.transform(resolver, [], nil, nil)).to eq('')
      end
      it 'when nil' do
        expect(subject.transform(resolver, nil, nil, nil)).to eq('')
      end
    end
  end

  describe '#transform comma separator' do
    subject { described_class.new(separator: ' ') }

    context 'join' do
      it 'when two elements, two words' do
        expect(subject.transform(resolver, first_array, nil, nil)).to eq('111 Bonus')
      end
      it 'when three elements, three words' do
        expect(subject.transform(resolver, second_array, nil, nil)).to eq('222 Holiday Pay')
      end
      it 'when four elements, four words' do
        expect(subject.transform(resolver, third_array, nil, nil)).to eq('333 Holiday Pay Bonus')
      end
      it 'when value is not an array' do
        expect(subject.transform(resolver, not_an_array, nil, nil))
          .to eq('This is not an array.')
      end
      it 'when empty array' do
        expect(subject.transform(resolver, [], nil, nil)).to eq('')
      end
      it 'when nil' do
        expect(subject.transform(resolver, nil, nil, nil)).to eq('')
      end
    end
  end
end
