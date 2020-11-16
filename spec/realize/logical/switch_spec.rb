# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require 'spec_helper'

RSpec.describe Realize::Logical::Switch do
  let(:resolver) { Objectable.resolver }
  let(:time)     { Time.parse('2019-01-10 2:00:00 PM UTC') }

  let(:sheep_record) do
    {
      animal: 'sheep',
      sheep_stuff: {
        fur: 'wooly'
      },
      looks_like: 'sheepish!'
    }
  end

  let(:dog_record) do
    {
      animal: 'dog',
      dog_stuff: {
        fur: 'fluffy'
      },
      looks_like: 'doggish'
    }
  end

  let(:dinosaur_record) do
    {
      animal: 'dinosaur',
      looks_like: 'dinosaur-like!'
    }
  end

  let(:config) do
    {
      cases: [
        {
          values: %w[sheep],
          transformers: [
            {
              type: 'r/value/resolve',
              key: 'sheep_stuff.fur'
            }
          ]
        },
        {
          values: 'dog',
          transformers: {
            type: 'r/value/resolve',
            key: 'dog_stuff.fur'
          }
        }
      ],
      default_transformers: [
        {
          type: 'r/value/resolve',
          key: :looks_like
        }
      ],
      key: 'animal'
    }
  end

  subject { described_class.make(config) }

  it 'resolves case (sheep)' do
    actual = subject.transform(resolver, sheep_record, time, sheep_record)

    expect(actual).to eq('wooly')
  end

  it 'resolves case (dog)' do
    actual = subject.transform(resolver, dog_record, time, dog_record)

    expect(actual).to eq('fluffy')
  end

  it 'resolves default case (dinosaur)' do
    actual = subject.transform(resolver, dinosaur_record, time, dinosaur_record)

    expect(actual).to eq('dinosaur-like!')
  end
end
