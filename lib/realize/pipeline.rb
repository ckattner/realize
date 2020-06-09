# frozen_string_literal: true

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
