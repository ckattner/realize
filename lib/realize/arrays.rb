# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Realize
  # Mix-in that adds some nice common array helpers.
  module Arrays
    def array(value)
      value.is_a?(Hash) ? [value] : Array(value)
    end
  end
end
