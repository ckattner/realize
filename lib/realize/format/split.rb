# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Realize
  class Format
    # Take a string value and split it on the specified 'by' value.  By default, it will be
    # split on a blank space.  For example: '123 456 789' would yield ['123', '456', '789'].
    # If the value is not a string then it will be converted to a string by calling #to_s on it.
    class Split
      acts_as_hashable

      DEFAULT_BY = ' '

      attr_reader :by

      def initialize(by: DEFAULT_BY)
        @by = by.to_s

        freeze
      end

      def transform(_resolver, value, _time, _record)
        value.to_s.split(by)
      end
    end
  end
end
