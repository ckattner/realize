# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Realize
  class File
    # Extract the file extension from the value.  If the value has multiple extensions then
    # only the last one will be returned.
    class Extname
      acts_as_hashable

      def transform(_resolver, value, _time, _record)
        ::File.extname(value.to_s)
      end
    end
  end
end
