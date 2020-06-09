# frozen_string_literal: true

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
