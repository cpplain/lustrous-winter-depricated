Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :resources, only: [:index, :create, :show, :update, :destroy]
  resources :subjects, only: [:index, :create, :update, :destroy]
  resources :resource_types, only: [:index, :create, :update, :destroy]
  resources :organizations, only: [:index, :create, :update, :destroy]
end
