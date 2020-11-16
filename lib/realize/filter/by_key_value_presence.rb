# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Realize
  class Filter
    # This transformer can take an object (will be converted to array) or array and
    # will go through each child object and see if the child record has a value for the
    # specified key.  If it does then it will select that record.
    class ByKeyValuePresence
      include Arrays
      acts_as_hashable

      attr_reader :key

      def initialize(key:)
        raise ArgumentError, 'key is required' if key.to_s.empty?

        @key = key

        freeze
      end

      def transform(resolver, value, _time, _record)
        records = array(value)

        records.reject do |record|
          resolver.get(record, key).to_s.empty?
        end
      end
    end
  end
end
