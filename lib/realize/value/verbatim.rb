# frozen_string_literal: true

module Realize
  class Value
    # Default transformer that does nothing.
    class Verbatim
      acts_as_hashable

      def transform(_resolver, value, _time, _record)
        value
      end
    end
  end
end
