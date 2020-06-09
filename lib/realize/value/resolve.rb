# frozen_string_literal: true

module Realize
  class Value
    # Basic transformer that can take an object and extract a value based off the transformer's
    # key.  If the value passed in is an array then it will select the first record.
    class Resolve
      acts_as_hashable

      attr_reader :key

      def initialize(key:)
        raise ArgumentError, 'key is required' if key.to_s.empty?

        @key = key

        freeze
      end

      def transform(resolver, value, _time, _record)
        record = first(value)

        resolver.get(record, key)
      end

      private

      def first(value)
        value.is_a?(Array) ? value.first : value
      end
    end
  end
end
