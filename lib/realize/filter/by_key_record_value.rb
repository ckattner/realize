# frozen_string_literal: true

module Realize
  class Filter
    # This transformer can take an array or a hash (put in array) and it understands how to
    # select only the records where a key's value looked up in the original record equates
    # to the transformer's value.
    class ByKeyRecordValue
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

      def transform(resolver, value, _time, original_record)
        records = array(value)

        records.select do |record|
          record_value = resolver.get(record, key)
          record_value == resolver.get(original_record, desired_value)
        end
      end
    end
  end
end
