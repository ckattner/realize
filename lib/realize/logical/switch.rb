# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require_relative 'switch/case'

module Realize
  class Logical
    # This type of transformer can be categorized as a "comparator", meaning its intended
    # desire is not a value resolution or value formatting, but a branching resolution.
    # Specifically, you can define cases where, if the value matches, the transformers for the
    # case would be executed.  If no case is matched then the default_transformers will be
    # executed.
    class Switch
      acts_as_hashable

      attr_reader :cases, :default_transformers, :key

      def initialize(key:, cases: [], default_transformers: [])
        raise ArgumentError, 'key is required' if key.to_s.empty?

        @cases                = Case.array(cases)
        @default_transformers = Transformers.array(default_transformers)
        @key                  = key

        freeze
      end

      def transform(resolver, value, time, record)
        resolved_value = resolver.get(record, key)
        matched_case   = cases.find { |c| c.match?(resolved_value) }
        transformers   = matched_case ? matched_case.transformers : default_transformers

        return value if transformers.empty?

        transformers.inject(value) do |memo, transformer|
          transformer.transform(resolver, memo, time, record)
        end
      end
    end
  end
end
