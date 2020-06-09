# frozen_string_literal: true

module Realize
  class Format
    # Formats a date/time value.  If the input is nil, it will output nil.  If an input_format
    # is configured then it will use that to explicitly parse it.  If an input_format is not
    # specified then it will use Ruby's DateTime#parse heuristics for parsing.  By default,
    # the output format is ISO-8601 standard (YYYY-MM-DD).  It is also possible to have
    # this output formatted time as well, but since it is named 'format_date', it is assumed
    # you want something date-only.
    #
    # See this link for more information about Ruby's DateTime parsing and formatting
    # details and also for valid format tokens:
    # https://ruby-doc.org/stdlib-2.6.6/libdoc/date/rdoc/DateTime.html#method-i-strftime
    class Date
      acts_as_hashable

      OUTPUT_FORMAT = '%F'

      attr_reader :input_format, :output_format

      def initialize(input_format: '', output_format: OUTPUT_FORMAT)
        @input_format  = input_format.to_s
        @output_format = output_format.to_s

        freeze
      end

      def transform(_resolver, value, _time, _record)
        return nil if value.to_s.empty?

        date_time =
          if value.respond_to?(:to_datetime)
            value.to_datetime
          elsif input_format?
            DateTime.strptime(value, input_format)
          else
            DateTime.parse(value)
          end

        date_time.strftime(output_format)
      end

      private

      def input_format?
        input_format.length.positive?
      end
    end
  end
end
