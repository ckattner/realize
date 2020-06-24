# frozen_string_literal: true

module Realize
  class Collection
    # Transformer to get the first item of a collection
    class First
      acts_as_hashable

      def transform(resolver, value, time, record)
        AtIndex.new(index: 0).transform(resolver, value, time, record)
      end
    end
  end
end
