# frozen_string_literal: true

module SmartAdapters
  module Exceptions
    class InvalidAdapterException < StandardError
      ERROR_MESSAGE = 'Invalid Adapter'

      def initialize
        super ERROR_MESSAGE
      end
    end
  end
end
