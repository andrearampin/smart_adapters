# frozen_string_literal: true

module SmartAdapters
  module Objects
    module Show
      class JsAdapter < SimpleDelegator
        include SmartAdapters::Util::Adapters::Js::Default

        def success(resource)
          render 'objects/show', locals: { resource: resource }
        end

        def failure(_resource)
          render js: '', status: :not_found
        end
      end
    end
  end
end
