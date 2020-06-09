# frozen_string_literal: true

module Realize
  # Mix-in that adds some nice common array helpers.
  module Arrays
    def array(value)
      value.is_a?(Hash) ? [value] : Array(value)
    end
  end
end
