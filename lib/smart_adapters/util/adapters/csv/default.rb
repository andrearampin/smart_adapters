# frozen_string_literal: true

module SmartAdapters
  module Util
    module Adapters
      module Csv
        module Default
          extend ActiveSupport::Concern
          include ::SmartAdapters::Util::Adapters::Base
        end
      end
    end
  end
end
