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
    class Uuid
      acts_as_hashable

      def transform(_resolver, _value, _time, _record)
        SecureRandom.uuid
      end
    end
  end
end
