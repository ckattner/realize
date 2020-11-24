# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require_relative 'base'

module Realize
  class Type
    # Ensure the value is an array by calling Kernel#Array on the value.  If the value is a hash
    # then it will ensure the hash data structure is preserved and placed within the array.
    # Normally calling Array(hash) would yield an array of key-value pair arrays.  For our
    # pipeline we generally treat hashes as "record-like" objects, so we need to ensure
    # we keep it in tact.
    #
    # This does not mean other data types do not suffer from Kernel#Array
    # converting it to something unexpected. For example, passing in a Time object would yield
    # an array of parts:
    #   Array(Time.now) => [2, 59, 10, 21, 11, 2020, 6, 326, false, "CST"]
    #
    # See: https://ruby-doc.org/core-2.7.2/Kernel.html#method-i-Array for more information.
    class Array < Base
      include Arrays

      def transform(_resolver, value, _time, _record)
        return nil if nullable && value.nil?

        array(value)
      end
    end
  end
end
