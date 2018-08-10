# frozen_string_literal: true

module SmartAdapters
  module Util
    module Adapters
      module Xml
        module Default
          extend ActiveSupport::Concern
          include ::SmartAdapters::Util::Adapters::Base

          def unauthorized
            render xml: {}, status: :unauthorized
          end
        end
      end
    end
  end
end
