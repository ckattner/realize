# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Realize
  class Value
    # This transformer can take in a hash of: "value" -> "new value".  It's basically a
    # simple way for doing simple if X = Y, then Z replacements.
    # This can be extended to include and customize case and type sensitivies, but right now
    # it is type and case-sensitive so be careful!
    class Map
      acts_as_hashable

      attr_reader :values

      def initialize(values: {})
        @values = values || {}

        freeze
      end

      def transform(_resolver, value, _time, _record)
        values.fetch(value, value)
      end
    end
  end
end
