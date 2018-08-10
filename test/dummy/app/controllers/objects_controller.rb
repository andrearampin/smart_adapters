# frozen_string_literal: true

class ObjectsController < ApplicationController
  include SmartAdapters

  protect_from_forgery except: :show

  def show
    current_adapter.success(resource)
  end

  private

  def resource
    @resource ||= { object: 'object content' }
  end
end
