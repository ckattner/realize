# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require 'spec_helper'

RSpec.describe Realize::File::Basename do
  let(:record)   { {} }
  let(:resolver) { nil }
  let(:time)     { nil }

  subject { described_class.new(suffix: suffix) }

  describe '#transform' do
    context 'when suffix is blank' do
      let(:suffix) { '' }

      it 'should return the filename with extension but not directory' do
        value = 'some/thing/here.txt'

        expect(subject.transform(resolver, value, time, record)).to eq('here.txt')
      end
    end

    context "when suffix is '.*'" do
      let(:suffix) { '.*' }

      it 'removes any extension (suffix)' do
        value = 'some/thing/here.txt'

        expect(subject.transform(resolver, value, time, record)).to eq('here')
      end
    end

    context "when suffix matches the file's extension" do
      let(:suffix) { '.txt' }

      it 'removes the extension' do
        value = 'some/thing/here.txt'

        expect(subject.transform(resolver, value, time, record)).to eq('here')
      end
    end

    context 'when suffixes case does not match' do
      let(:suffix) { '.TXT' }

      it 'does not remove the extension' do
        value = 'some/thing/here.txt'

        expect(subject.transform(resolver, value, time, record)).to eq('here.txt')
      end
    end
  end
end
