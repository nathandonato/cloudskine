# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'login', to: 'authentication#login'

      resources :users, only: [:create]
      resources :entries, except: [:new]
      resources :prompts, except: %i[new destroy]
    end
  end
end
