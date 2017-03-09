Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :resources, only: [:index, :create, :update, :destroy]
  resources :subjects, only: [:create, :update, :destroy]
end
