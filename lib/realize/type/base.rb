# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Realize
  class Type
    # Common code for all Type Transformer subclasses.
    class Base
      acts_as_hashable

      attr_reader :nullable

      def initialize(nullable: false)
        @nullable = nullable || false

        freeze
      end
    end
  end
end
