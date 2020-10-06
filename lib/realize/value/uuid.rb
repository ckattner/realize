# frozen_string_literal: true

module Realize
  class Value
    # Return a current Time object.
    class Uuid
      acts_as_hashable

      def transform(_resolver, _value, _time, _record)
        SecureRandom.uuid
      end
    end
  end
end
