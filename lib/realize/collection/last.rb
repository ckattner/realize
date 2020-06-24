# frozen_string_literal: true

module Realize
  class Collection
    # Transformer to get the last item of a collection
    class Last
      acts_as_hashable

      def transform(resolver, value, time, record)
        AtIndex.new(index: -1).transform(resolver, value, time, record)
      end
    end
  end
end
