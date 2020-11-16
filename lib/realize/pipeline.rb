# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Realize
  # Main runner that encapsulates a collection of transformers and knows how to kick off the
  # transformation process.
  class Pipeline
    attr_reader :resolver, :transformers

    def initialize(transformers = [], resolver: Objectable.resolver)
      raise ArgumentError, 'resolver is required' unless resolver

      @resolver     = resolver
      @transformers = Transformers.array(transformers)

      freeze
    end

    def transform(record, time = Time.now.utc)
      transformers.inject(record) do |memo, transformer|
        transformer.transform(resolver, memo, time, record)
      end
    end
  end
end
