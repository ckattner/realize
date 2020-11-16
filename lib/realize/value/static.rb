# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Realize
  class Value
    # Transformer that always returns a static value
    class Static
      acts_as_hashable

      attr_reader :value

      def initialize(value: nil)
        @value = value

        freeze
      end

      def transform(_resolver, _value, _time, _record)
        value
      end
    end
  end
end
