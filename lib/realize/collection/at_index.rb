# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Realize
  class Collection
    # Transformer to get an item of a collection
    class AtIndex
      acts_as_hashable

      attr_reader :index

      def initialize(index:)
        raise ArgumentError, 'index is required' if index.to_s.empty?

        @index = index.to_i

        freeze
      end

      def transform(_resolver, value, _time, _record)
        value.is_a?(Array) ? value[index] : value
      end
    end
  end
end
