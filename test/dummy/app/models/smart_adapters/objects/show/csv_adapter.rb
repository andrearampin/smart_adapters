# frozen_string_literal: true

module SmartAdapters
  module Objects
    module Show
      class CsvAdapter < SimpleDelegator
        include SmartAdapters::Util::Adapters::Csv::Default

        def success(resource)
          render 'objects/show', locals: { resource: resource }, status: :ok
        end

        def failure(_resource)
          render csv: '', status: :not_found
        end
      end
    end
  end
end
