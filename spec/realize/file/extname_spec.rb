# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require 'spec_helper'

RSpec.describe Realize::File::Extname do
  let(:record)   { {} }
  let(:resolver) { nil }
  let(:time)     { nil }

  describe '#transform' do
    it 'returns only the extension' do
      value = 'some/thing/here.txt'

      expect(subject.transform(resolver, value, time, record)).to eq('.txt')
    end

    specify 'multiple extensions only returns the last' do
      value = 'some/thing/here.txt.erb'

      expect(subject.transform(resolver, value, time, record)).to eq('.erb')
    end

    specify 'blank file returns blank extension' do
      value = ''

      expect(subject.transform(resolver, value, time, record)).to eq('')
    end
  end
end
