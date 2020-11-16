# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require_relative 'sort/direction'

module Realize
  class Collection
    # Transformer to take an array of objects and sort by the given key
    # and by the given sort direction. Defaulting to ascending.
    class Sort
      include Arrays
      include Direction
      acts_as_hashable

      DEFAULT_ORDER = ASCENDING

      attr_reader :key, :order

      def initialize(key:, order: DEFAULT_ORDER)
        raise ArgumentError, 'key is required' if key.to_s.empty?

        @key   = key
        @order = Direction.const_get(order.to_s.upcase.to_sym)

        freeze
      end

      def transform(resolver, value, _time, _record)
        records = array(value)

        sorted = records.sort_by { |hsh| resolver.get(hsh, key) }

        order == DESCENDING ? sorted.reverse : sorted
      end
    end
  end
end
