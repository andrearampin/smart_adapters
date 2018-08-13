# frozen_string_literal: true

module SmartAdapters
  class Delegator
    # List of formats supported by SmartAdapters
    FORMATS = %i[json html js xml text csv]

    # Initialise SmartAdapters delegator
    # @param [ActionController]
    # @param [ActionDispatch::Request]
    # @return [SmartAdapters::Adapter::Delegator]
    def initialize(manager, request)
      @manager = manager
      @request = request
    end

    # Fetch Adatapter base on request
    # @raise [SmartAdapters::Exceptions::InvalidRequestFormatException]
    # @raise [SmartAdapters::Exceptions::InvalidRequestParamsException]
    # @return [SmartAdapters::<Controller>::<Action>::<Format>Adapter]
    def load
      unless valid_params?
        raise SmartAdapters::Exceptions::InvalidRequestParamsException
      end
      unless valid_format?
        raise SmartAdapters::Exceptions::InvalidRequestFormatException
      end
      adapter_finder.new(request_manager)
    end

    # Return the action requested by the manager.
    # @return [string]
    def action
      request_manager.action_name
    end

    # Return the controller requested.
    # @return [string]
    def manager
      request_manager
    end

    FORMATS.each do |format_name|
      # Verify if the request format is valid.
      # @return [Boolean]
      define_method "#{format_name}?" do
        request_format.try(:"#{format_name}?")
      end
    end

    # Check if the request has a valid format.
    # @return [Boolean]
    def valid_format?
      FORMATS.map { |format| send("#{format}?") }.any?
    end

    # Check if it is an API request
    # @return [Boolean]
    def api?
      json?
    end

    # Check if it is a session request
    # @return [Boolean]
    def session?
      html?
    end

    # Check if the request has a valid params.
    # @return [Boolean]
    def valid_params?
      request_params.present?
    end

    # Fetch request params
    # @return [Hash]
    def request_params
      @params ||= @request.params
    end

    private

    attr_writer :manager
    attr_writer :request
    attr_writer :params
    attr_writer :format

    # Dig into the request params
    # @param [Hash { key: nil }]
    # @return [String]
    def request_detail(key:)
      request_params.dig(key).to_s.camelize
    end

    # Fecth request format.
    # @return [Mime::Type]
    def request_format
      @format ||= @request.format
    end

    # Fetch request manager
    # @return [ActionController]
    def request_manager
      @manager
    end

    # Find adapter for the given request (resource, action, format)
    # @raise [String]
    def adapter_finder
      resource = request_detail(key: :controller)
      req_action = request_detail(key: :action)
      req_format = request_format.symbol.to_s.camelize
      "SmartAdapters::#{resource}::#{req_action}::#{req_format}Adapter"
        .constantize
    end
  end
end
