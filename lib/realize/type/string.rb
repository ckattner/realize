# frozen_string_literal: true

module Realize
  class Type
    # Call #to_s on the value and return result.
    class String
      acts_as_hashable

      attr_reader :nullable

      def initialize(nullable: false)
        @nullable = nullable || false
      end

      def transform(_resolver, value, _time, _record)
        return nil if nullable && value.nil?

        value.to_s
      end
    end
  end
end
