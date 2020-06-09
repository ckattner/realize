# frozen_string_literal: true

module Realize
  class Value
    # Transformer that always returns nil
    class Null
      acts_as_hashable

      def transform(_resolver, _value, _time, _record)
        nil
      end
    end
  end
end
