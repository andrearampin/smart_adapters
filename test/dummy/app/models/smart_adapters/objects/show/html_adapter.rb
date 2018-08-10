# frozen_string_literal: true

module SmartAdapters
  module Objects
    module Show
      class HtmlAdapter < SimpleDelegator
        include SmartAdapters::Util::Adapters::Html::Default

        def success(resource)
          render 'objects/show', locals: { resource: resource }
        end

        def failure(_resource)
          redirect_back(
            fallback_location: root_path,
            flash: { error: 'Resource not found' }
          )
        end
      end
    end
  end
end
