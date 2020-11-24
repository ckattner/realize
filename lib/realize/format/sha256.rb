# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Realize
  class Format
    # Convert the value into a SHA256 encoded string.  There are two main encoding formats:
    # hex or base64.  By default, the value will be hexidecimal encoded.
    class Sha256
      acts_as_hashable

      module EncodingFormat
        HEX    = :hex
        BASE64 = :base64
      end
      include EncodingFormat

      DEFAULT_ENCODING_FORMAT = HEX

      attr_reader :encoding_format

      def initialize(encoding_format: DEFAULT_ENCODING_FORMAT)
        @encoding_format = EncodingFormat.const_get(encoding_format.to_s.upcase.to_sym)

        freeze
      end

      def transform(_resolver, value, _time, _record)
        Digest::SHA256.send(sha_method, value.to_s)
      end

      private

      def sha_method
        case encoding_format
        when HEX
          :hexdigest
        when BASE64
          :base64digest
        end
      end
    end
  end
end
