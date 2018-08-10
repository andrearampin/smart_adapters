# frozen_string_literal: true

module SmartAdapters
  module Exceptions
    class InvalidRequestFormatException < StandardError
      ERROR_MESSAGE = 'Request format not supported.' \
                      'Formats available: html, json'

      def initialize
        super ERROR_MESSAGE
      end
    end
  end
end
