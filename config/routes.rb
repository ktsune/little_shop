Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/merchants', to: 'merchants#index'
  get '/merchants/new', to: 'merchants#new'
  get '/merchants/:id', to: 'merchants#show'
  post '/merchants', to: 'merchants#create'
  get '/merchants/:id/edit', to: 'merchants#edit'
  patch '/merchants/:id', to: 'merchants#update'
  delete '/merchants/:id', to: 'merchants#destroy'

  get '/items', to: 'items#index'
  get '/merchants/:merchant_id/items', to: 'items#index'
  get '/items/:id', to: 'items#show'
  get '/merchants/:merchant_id/items/new', to: 'items#new'
  post '/merchants/:merchant_id/items', to: 'items#create'
  get '/items/:id/edit', to: 'items#edit'
  patch '/items/:id', to: 'items#update'
  delete '/items/:id', to: 'items#destroy'

  get '/reviews/:id/edit', to: 'reviews#edit'
  patch '/reviews/:id', to: 'reviews#update'
  get '/items/:item_id/reviews/new', to: 'reviews#new'
  post '/items/:item_id', to: 'reviews#create'
  delete '/reviews/:id', to: 'reviews#destroy'

  get '/cart', to: 'cart#show'
  post '/cart/:item_id', to: 'cart#create'
  patch '/cart/add_item/:item_id', to: 'cart#add_item'
  patch '/cart/remove_item/:item_id', to: 'cart#remove_item'
  delete '/cart/:item_id', to: 'cart#delete_item'
  delete '/cart', to: 'cart#destroy'

  resources :orders, only: [:new, :create, :show]
end
