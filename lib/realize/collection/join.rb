# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Realize
  class Collection
    # Transformer to return a new string by concatenating all the elements of an array
    # specified by a separator character. The transformer also can be configured to specifiy
    # which elements to start from and end to that will make up the returned string.
    class Join
      include Arrays
      acts_as_hashable

      DEFAULT_END_INDEX     = -1
      DEFAULT_SEPARATOR     = ''
      DEFAULT_START_INDEX   = 0

      attr_reader :separator, :end_index, :start_index

      def initialize(separator: DEFAULT_SEPARATOR, start_index: DEFAULT_START_INDEX,
                     end_index: DEFAULT_END_INDEX)
        @separator    = separator || DEFAULT_SEPARATOR
        @start_index  = start_index || DEFAULT_START_INDEX
        @end_index    = end_index || DEFAULT_END_INDEX

        freeze
      end

      def transform(_resolver, value, _time, _record)
        items = array(value)

        (items[start_index..end_index] || []).join(separator)
      end
    end
  end
end
