# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Realize
  class File
    # Takes the value and strips out the directory.  Suffix is provided as an option which strips
    # out the extension (last period and beyond).  If '.*' is passed in as the suffix then any
    # extension will be stripped.  Note that files with multiple extensions will only have their
    # last extesion removed.
    class Basename
      acts_as_hashable

      attr_reader :suffix

      def initialize(suffix: '')
        @suffix = suffix.to_s

        freeze
      end

      def transform(_resolver, value, _time, _record)
        ::File.basename(value.to_s, suffix)
      end
    end
  end
end
