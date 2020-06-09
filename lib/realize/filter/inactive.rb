# frozen_string_literal: true

module Realize
  class Filter
    # This transformer can take in an array or hash (put in an array) and filters out
    # the objects who have a start date greater than today or end date less than today.
    # If a start or end date is null then it is assumed to be infinity.
    class Inactive
      include Arrays
      acts_as_hashable

      DEFAULT_START_DATE_KEY  = 'start_date'
      DEFAULT_END_DATE_KEY    = 'end_date'

      attr_reader :start_date_key, :end_date_key

      def initialize(
        start_date_key: DEFAULT_START_DATE_KEY,
        end_date_key: DEFAULT_END_DATE_KEY
      )
        raise ArgumentError, 'start_date_key is required'  if start_date_key.to_s.empty?
        raise ArgumentError, 'end_date_key is required'    if end_date_key.to_s.empty?

        @start_date_key  = start_date_key
        @end_date_key    = end_date_key

        freeze
      end

      def transform(resolver, value, time, _record)
        current_time  = time.utc
        records       = array(value)

        records.select do |record|
          start_time  = parse_date(resolver.get(record, start_date_key))
          end_time    = parse_date(resolver.get(record, end_date_key))

          valid?(start_time, end_time, current_time)
        end
      end

      private

      def valid?(start_time, end_time, current_time)
        valid_start?(start_time, current_time) && valid_end?(end_time, current_time)
      end

      def valid_start?(start_time, current_time)
        start_time.nil? || start_time <= current_time
      end

      def valid_end?(end_time, current_time)
        end_time.nil? || end_time >= current_time
      end

      def parse_date(value)
        value.to_s.empty? ? nil : Time.parse(value.to_s).utc
      end
    end
  end
end
