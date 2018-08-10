# frozen_string_literal: true

module SmartAdapters
  module Objects
    module Show
      class XmlAdapter < SimpleDelegator
        include SmartAdapters::Util::Adapters::Xml::Default

        def success(resource)
          render xml: resource, status: :ok
        end

        def failure(_resource)
          render xml: {}, status: :not_found
        end
      end
    end
  end
end
