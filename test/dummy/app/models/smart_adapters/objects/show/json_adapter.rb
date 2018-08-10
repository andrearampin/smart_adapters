# frozen_string_literal: true

module SmartAdapters
  module Objects
    module Show
      class JsonAdapter < SimpleDelegator
        include SmartAdapters::Util::Adapters::Json::Default

        def success(resource)
          render json: resource, status: :ok
        end

        def failure(_resource)
          render json: {}, status: :not_found
        end
      end
    end
  end
end
