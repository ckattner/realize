# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require 'spec_helper'

RSpec.describe Realize::Transformers do
  describe '#make' do
    it 'makes transformers with no arguments' do
      transformer = { type: 'r/value/blank' }

      expect { described_class.make(transformer) }.not_to raise_error
    end
  end
end
