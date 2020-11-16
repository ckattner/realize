# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Realize
  class Format
    # This transformer takes in a value and replaces any whitespace characters (\t\r\n\f\v)
    # with a blank space.
    class RemoveWhitespace
      acts_as_hashable

      def transform(_resolver, value, _time, _record)
        value.to_s.gsub(/\s+/, ' ')
      end
    end
  end
end
