# frozen_string_literal: true

module Realize
  class Format
    # This transformer takes in a value and replaces all occurrences of the given
    # original pattern with the replacement pattern.
    class StringReplace
      acts_as_hashable

      attr_reader :original, :replacement

      def initialize(original:, replacement:)
        raise ArgumentError, 'original is required' if original.to_s.empty?

        @original    = original
        @replacement = replacement.to_s

        freeze
      end

      def transform(_resolver, value, _time, _record)
        value.to_s.gsub(original, replacement)
      end
    end
  end
end
