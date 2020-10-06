# frozen_string_literal: true

module Realize
  class Value
    # Return a current Time object.
    class Now
      acts_as_hashable

      DEFAULT_UTC_OFFSET = '+00:00'

      attr_reader :utc_offset

      def initialize(utc_offset: DEFAULT_UTC_OFFSET)
        @utc_offset = utc_offset || DEFAULT_UTC_OFFSET

        freeze
      end

      def transform(_resolver, _value, _time, _record)
        Time.now.utc.localtime(utc_offset)
      end
    end
  end
end
