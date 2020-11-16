# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require 'spec_helper'

RSpec.describe Realize do
  let(:resolver) { Objectable.resolver }

  let(:transformers) do
    Realize::Transformers.array(
      type: 'r/value/resolve',
      key: :name
    )
  end

  specify '#pipeline returns new instance of Pipeline' do
    actual = described_class.pipeline(transformers, resolver: resolver)

    expect(actual).to              be_an_instance_of(Realize::Pipeline)
    expect(actual.resolver).to     eql(resolver)
    expect(actual.transformers).to eql(transformers)
  end

  describe 'Readme Examples' do
    let(:record) do
      {
        id: 1,
        created_at: '2020-03-04T12:34:56Z',
        first: 'Frank',
        last: 'Rizzo'
      }
    end

    it 'gets formatted date' do
      transformers = [
        {
          type: 'r/value/resolve',
          key: :created_at
        },
        {
          type: 'r/format/date',
          output_format: '%D'
        }
      ]

      value = Realize.pipeline(transformers).transform(record) # 03/04/20

      expect(value).to eq('03/04/20')
    end
  end
end
