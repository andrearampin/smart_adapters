# frozen_string_literal: true

module SmartAdapters
  module Exceptions
    class InvalidRequestParamsException < StandardError
      ERROR_MESSAGE = 'Missing request params'

      def initialize
        super ERROR_MESSAGE
      end
    end
  end
end
