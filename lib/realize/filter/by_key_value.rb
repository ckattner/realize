# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Realize
  class Filter
    # This transformer can take an array or a hash (put in array) and it understands how to
    # select only the records where a key's value statically equates to the transformer's
    # value.
    class ByKeyValue
      include Arrays
      acts_as_hashable

      attr_reader :key, :value

      # value is also passed into #transform so we need to alias it so its not shadowed by
      # the argument.
      alias desired_value value

      def initialize(key:, value:)
        raise ArgumentError, 'key is required' if key.to_s.empty?

        @key    = key
        @value  = value

        freeze
      end

      def transform(resolver, value, _time, _record)
        records = array(value)

        records.select do |record|
          record_value = resolver.get(record, key)

          record_value == desired_value
        end
      end
    end
  end
end
