# frozen_string_literal: true

module SmartAdapters
  module Util
    module Adapters
      module Js
        module Default
          extend ActiveSupport::Concern
          include ::SmartAdapters::Util::Adapters::Base

          def unauthorized
            render js: '', status: :unauthorized
          end
        end
      end
    end
  end
end
