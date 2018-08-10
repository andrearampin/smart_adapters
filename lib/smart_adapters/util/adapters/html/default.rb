# frozen_string_literal: true

module SmartAdapters
  module Util
    module Adapters
      module Html
        module Default
          extend ActiveSupport::Concern
          include ::SmartAdapters::Util::Adapters::Base

          def unauthorized
            redirect_to root_path, flash: { warning: 'Unauthorized' }
          end
        end
      end
    end
  end
end
