# frozen_string_literal: true

module Realize
  class Type
    # Convert input into either true, false, or nil.
    # By default nils will return false unless nullable: true is passed in.
    # This transformer is very liberal in its parsing and will return true for:
    #   true, 'true', 't', 'TRUE', 'True', 1, '1', 'Y', 'yes', 'Yes', 'YES'
    # All other non-truthy values will evaluate to false, such as:
    #   false, 'false', 'f', 'FALSE', 'False', 0, '0', 'N', 'no', 'No', 'NO', {}, [], '',
    #   'abc', 123, :abc, etc...
    class Boolean
      acts_as_hashable

      attr_reader :nullable

      def initialize(nullable: false)
        @nullable = nullable || false
      end

      def transform(_resolver, value, _time, _record)
        if nullable && value.nil?
          nil
        elsif truthy?(value)
          true
        else
          false
        end
      end

      private

      def truthy?(value)
        value.to_s.match?(/(true|t|yes|y|1)$/i)
      end
    end
  end
end
