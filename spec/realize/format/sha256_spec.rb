# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require 'spec_helper'

RSpec.describe Realize::Format::Sha256 do
  let(:record)     { {} }
  let(:resolver)   { nil }
  let(:time)       { nil }

  subject { described_class.new(encoding_format: encoding_format) }

  describe '#transform' do
    context 'when encoding_format is hex' do
      let(:encoding_format) { :hex }

      it 'returns a SHA256 hashed hexidecimal string' do
        value    = 'something'
        expected = Digest::SHA256.hexdigest(value)

        actual = subject.transform(resolver, value, time, record)

        expect(actual).to eq(expected)
      end
    end

    context 'when encoding_format is base64' do
      let(:encoding_format) { :base64 }

      it 'returns a SHA256 hashed hexidecimal string' do
        value    = 'something'
        expected = Digest::SHA256.base64digest(value)

        actual = subject.transform(resolver, value, time, record)

        expect(actual).to eq(expected)
      end
    end
  end
end
