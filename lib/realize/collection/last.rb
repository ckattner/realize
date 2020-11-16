# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Realize
  class Collection
    # Transformer to get the last item of a collection
    class Last
      acts_as_hashable

      def transform(resolver, value, time, record)
        AtIndex.new(index: -1).transform(resolver, value, time, record)
      end
    end
  end
end
