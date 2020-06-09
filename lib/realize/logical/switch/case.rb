# frozen_string_literal: true

module Realize
  class Logical
    class Switch
      # This class encapsulates and defines what a switch case statement is.  The values
      # attribute is a list of values to test.  The transformers are the transformers to
      # execute if the value matches.
      class Case
        include Arrays
        acts_as_hashable

        attr_reader :values, :transformers

        def initialize(values: [], transformers: [])
          @values       = array(values).map(&:to_s).to_set
          @transformers = Transformers.array(transformers)
        end

        def match?(value)
          values.include?(value.to_s)
        end
      end
    end
  end
end
