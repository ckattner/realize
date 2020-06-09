# frozen_string_literal: true

module Realize
  class Format
    # This transformer takes in a value and replaces any whitespace characters (\t\r\n\f\v)
    # with a blank space.
    class RemoveWhitespace
      acts_as_hashable

      def transform(_resolver, value, _time, _record)
        value.to_s.gsub(/\s+/, ' ')
      end
    end
  end
end
