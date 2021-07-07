# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require 'spec_helper'

RSpec.describe Realize::Collection::Sort do
  let(:resolver) { Objectable.resolver }
  let(:time)     { Time.parse('2019-01-10 2:00:00 PM UTC') }
  let(:key)      { 'date' }

  let(:one) do
    {
      id: 1,
      date: '2020-01-01',
      name: 'first'
    }
  end

  let(:two) do
    {
      id: 2,
      date: '2020-02-10',
      name: 'second'
    }
  end

  let(:three) do
    {
      id: 3,
      date: '2020-03-07',
      name: 'third'
    }
  end

  let(:four) do
    {
      id: 4,
      date: '2020-02-07',
      name: 'fourth'
    }
  end

  let(:value) { [one, two, three, four] }

  let(:asc_sorted_by_dates) { [one, four, two, three] }

  let(:desc_sorted_by_ids) { [four, three, two, one] }

  let(:desc_sorted_by_dates) { [three, two, four, one] }

  let(:asc_sorted_by_names) { [one, four, two, three] }

  subject { described_class.new(key: key) }

  describe '#transform' do
    context 'sorts' do
      it 'when value is an array' do
        expect(subject.transform(resolver, value, time, value)).to eq(asc_sorted_by_dates)
      end
      it 'when value is not an array' do
        expect(subject.transform(resolver, { id: 12, date: '2020-01-01' }, time, value))
          .to eq([{ id: 12, date: '2020-01-01' }])
      end
      specify 'integers' do
        subject = described_class.new(key: 'id', order: 'desc')
        expect(subject.transform(resolver, value, time, value)).to eq(desc_sorted_by_ids)
      end

      specify 'strings' do
        subject = described_class.new(key: 'name')
        expect(subject.transform(resolver, value, time, value)).to eq(asc_sorted_by_names)
      end
    end

    context 'supports both sorst directions' do
      it 'defaults to ascending sort' do
        subject = described_class.new(key: key)
        expect(subject.transform(resolver, value, time, value)).to eq(asc_sorted_by_dates)
      end
      it 'sorts ascending' do
        subject = described_class.new(key: key, order: 'asc')
        expect(subject.transform(resolver, value, time, value)).to eq(asc_sorted_by_dates)
      end
      it 'sorts descending' do
        subject = described_class.new(key: key, order: 'desc')
        expect(subject.transform(resolver, value, time, value)).to eq(desc_sorted_by_dates)
      end
    end

    context 'sort orders' do
      it 'allows shortened versions' do
        expect { described_class.new(key: key, order: 'asc') }.not_to raise_error
        expect { described_class.new(key: key, order: 'ASC') }.not_to raise_error
        expect { described_class.new(key: key, order: 'desc') }.not_to raise_error
        expect { described_class.new(key: key, order: 'DESC') }.not_to raise_error
      end

      it 'allows full versions' do
        expect { described_class.new(key: key, order: 'ascending') }.not_to raise_error
        expect { described_class.new(key: key, order: 'ASCENDING') }.not_to raise_error
        expect { described_class.new(key: key, order: 'descending') }.not_to raise_error
        expect { described_class.new(key: key, order: 'DESCENDING') }.not_to raise_error
      end
    end

    context 'exceptions' do
      it 'throws exception for nil key' do
        expect { described_class.new(key: nil) }.to raise_error('key is required')
      end

      it 'thows an exception for bad orders' do
        expect { described_class.new(key: key, order: 'bananas') }.to raise_error(NameError)
      end
    end
  end
end
