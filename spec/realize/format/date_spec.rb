# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require 'spec_helper'

RSpec.describe Realize::Format::Date do
  let(:resolver) { Objectable.resolver }

  describe '#transform' do
    context 'with default input and output formats' do
      describe 'value type tests' do
        context 'when value is a string' do
          let(:value) { '2020-03-12T00:11:22+2' }

          it 'parses and formats' do
            expect(subject.transform(resolver, value, nil, nil)).to eq('2020-03-12')
          end
        end

        context 'when value is a Date instance' do
          let(:value) { Date.parse('2020-03-12') }

          it 'parses and formats' do
            expect(subject.transform(resolver, value, nil, nil)).to eq('2020-03-12')
          end
        end

        context 'when value is a DateTime instance' do
          let(:value) { DateTime.parse('2020-03-12T00:11:22+2') }

          it 'parses and formats' do
            expect(subject.transform(resolver, value, nil, nil)).to eq('2020-03-12')
          end
        end

        context 'when value is a Time instance' do
          let(:value) { Time.parse('2020-03-12T00:11:22+2') }

          it 'parses and formats' do
            expect(subject.transform(resolver, value, nil, nil)).to eq('2020-03-12')
          end
        end
      end
    end
  end

  context 'with custom input and output formats' do
    let(:input_format)  { '%m/%d/%y %k:%M %p' }
    let(:output_format) { '%m-%d-%Y' }
    let(:value)         { '01/30/02 4:53 PM' }

    subject do
      described_class.new(
        input_format: input_format,
        output_format: output_format
      )
    end

    it 'parses and formats' do
      expect(subject.transform(resolver, value, nil, nil)).to eq('01-30-2002')
    end
  end

  context 'when formatting time' do
    let(:output_format) { '%T' }

    subject do
      described_class.new(
        output_format: output_format
      )
    end

    context 'when value is a string' do
      let(:value) { '2020-03-12T00:11:22+2' }

      it 'parses and formats' do
        expect(subject.transform(resolver, value, nil, nil)).to eq('00:11:22')
      end
    end

    context 'when value is a Date instance' do
      let(:value) { Date.parse('2020-03-12') }

      it 'parses and formats' do
        expect(subject.transform(resolver, value, nil, nil)).to eq('00:00:00')
      end
    end

    context 'when value is a DateTime instance' do
      let(:value) { DateTime.parse('2020-03-12T00:11:22+2') }

      it 'parses and formats' do
        expect(subject.transform(resolver, value, nil, nil)).to eq('00:11:22')
      end
    end

    context 'when value is a Time instance' do
      let(:value) { Time.parse('2020-03-12T00:11:22+2') }

      it 'parses and formats' do
        expect(subject.transform(resolver, value, nil, nil)).to eq('00:11:22')
      end
    end
  end
end
