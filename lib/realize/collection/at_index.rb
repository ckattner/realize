# frozen_string_literal: true

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
