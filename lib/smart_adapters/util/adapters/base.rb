# frozen_string_literal: true

module SmartAdapters
  module Util
    module Adapters
      module Base
        attr_reader :resource

        def success(_resource = nil)
          raise SmartAdapters::Exceptions::InvalidAdapterException
        end

        def failure(_resource = nil)
          raise SmartAdapters::Exceptions::InvalidAdapterException
        end

        protected

        # Expose a variable to the entire class under the name @resource.
        # @param [Object]
        # @return [Object]
        def load_resource(resource)
          @resource = resource
        end
      end
    end
  end
end
