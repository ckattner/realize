# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

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
