# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Realize
  class Format
    # Pad a string value with a specified 'with' value (defaults to blank space) up until the
    # passed in length is reached.  The 'side' option can be used to specify whether the
    # padding should occur to the left or right side of the value.
    # Examples:
    #   'ABC' + [length: 10, side: 'left', with: '123'] => '1231231ABC'
    #   'ABC' + [length: 10, side: 'right, with: '123'] => 'ABC1231231'
    #
    # If length is not specified or is less than the actual value's length then no padding
    # will occur.
    class Pad
      acts_as_hashable

      module Side
        LEFT = :left
        RIGHT = :right
      end
      include Side

      DEFAULT_SIDE = LEFT
      DEFAULT_WITH = ' '

      attr_reader :length, :side, :with

      def initialize(length: nil, side: LEFT, with: DEFAULT_WITH)
        @length = length ? length.to_i : nil
        @side   = Side.const_get(side.to_s.upcase.to_sym)
        @with   = with.to_s

        freeze
      end

      def transform(_resolver, value, _time, _record)
        return value unless length

        value.to_s.send(just_method, length, with)
      end

      private

      def just_method
        case side
        when LEFT
          :rjust
        when RIGHT
          :ljust
        end
      end
    end
  end
end
