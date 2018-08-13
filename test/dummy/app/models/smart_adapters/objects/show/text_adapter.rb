# frozen_string_literal: true

module SmartAdapters
  module Objects
    module Show
      class TextAdapter < SimpleDelegator
        include SmartAdapters::Util::Adapters::Xml::Default

        def success(resource)
          render 'objects/show', locals: { resource: resource }, status: :ok
        end

        def failure(_resource)
          render text: '', status: :not_found
        end
      end
    end
  end
end
