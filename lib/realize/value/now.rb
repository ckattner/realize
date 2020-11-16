# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Realize
  class Value
    # Return a current Time object.
    class Now
      acts_as_hashable

      DEFAULT_UTC_OFFSET = '+00:00'

      attr_reader :utc_offset

      def initialize(utc_offset: DEFAULT_UTC_OFFSET)
        @utc_offset = utc_offset || DEFAULT_UTC_OFFSET

        freeze
      end

      def transform(_resolver, _value, _time, _record)
        Time.now.utc.localtime(utc_offset)
      end
    end
  end
end
