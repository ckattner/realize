# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Realize
  class Format
    # Call #to_s.downcase on the value and return result.
    class Lowercase
      acts_as_hashable

      def transform(_resolver, value, _time, _record)
        value.to_s.downcase
      end
    end
  end
end
