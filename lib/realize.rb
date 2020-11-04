# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require 'acts_as_hashable'
require 'objectable'
require 'securerandom'
require 'stringento'
require 'time'

require_relative 'realize/arrays'
require_relative 'realize/transformers'
require_relative 'realize/pipeline'

# Top-level syntactic sugar.
module Realize
  class << self
    def pipeline(transformers = [], resolver: Objectable.resolver)
      Pipeline.new(transformers, resolver: resolver)
    end
  end
end
