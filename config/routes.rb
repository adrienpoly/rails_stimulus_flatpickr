# frozen_string_literal: true

Rails.application.routes.draw do
  scope '(:locale)', locale: /fr/ do
    root 'appointments#index'
    resources :appointments, only: %i[index create show update destroy], path: '/'
  end
end
