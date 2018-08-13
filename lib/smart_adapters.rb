# frozen_string_literal: true

require 'smart_adapters/railtie'

require 'smart_adapters/delegator'

require 'smart_adapters/concerns/smart_adapters'

require 'smart_adapters/exceptions/invalid_adapter_exception'
require 'smart_adapters/exceptions/invalid_request_format_exception'
require 'smart_adapters/exceptions/invalid_request_params_exception'

require 'smart_adapters/util/adapters/base'
require 'smart_adapters/util/adapters/html/default'
require 'smart_adapters/util/adapters/json/default'
require 'smart_adapters/util/adapters/js/default'
require 'smart_adapters/util/adapters/xml/default'
require 'smart_adapters/util/adapters/csv/default'
require 'smart_adapters/util/adapters/text/default'

module SmartAdapters
end
