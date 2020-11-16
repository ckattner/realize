# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Realize
  class Collection
    class Sort
      # Constants describing the possible values of 'direction' for a Sort instance.
      module Direction
        # providing a few different ways to specify.
        ASCENDING  = ASC  = 'ASC'
        DESCENDING = DESC = 'DESC'
      end
    end
  end
end
