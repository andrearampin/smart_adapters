# frozen_string_literal: true

Rails.application.routes.draw do
  root controller: :objects, action: :show
  resource :objects, only: :show
end
