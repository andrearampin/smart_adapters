# frozen_string_literal: true

module SmartAdapters
  extend ActiveSupport::Concern

  # Load request adapter
  # @return [SmartAdapters::<Controller>::<Action>::<Format>Adapter]
  def current_adapter
    @current_adapter ||= current_delegator.load
  end

  # Load request adapter
  # @return [SmartAdapters::Delegator]
  def current_delegator
    @current_delegator ||= ::SmartAdapters::Delegator.new(self, request)
  end
end
