# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require_relative 'base'

module Realize
  class Type
    # Call #to_s on the value and return result.
    class String < Base
      def transform(_resolver, value, _time, _record)
        return nil if nullable && value.nil?

        value.to_s
      end
    end
  end
end
