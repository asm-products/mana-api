Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users

  namespace :api, defaults: {format: 'json'} do
  	namespace :v1 do
  		resources :clients
  	end
  end
end
