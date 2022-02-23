Rails.application.routes.draw do
  resources :stores
  resources :products
  resources :orders, only: %i[index create show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
