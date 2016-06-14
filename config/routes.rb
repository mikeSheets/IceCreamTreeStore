Rails.application.routes.draw do
  devise_for :users

  root 'home#index'

  get 'home/index' , to: 'home#index'


  namespace 'admin' do
    resources :products
    resources :orders
  end

  get 'cart', to: 'cart#index'
  get 'cart/address', to: 'cart#address'
  get 'cart/billing', to: 'cart#billing'
  get 'cart/checkout', to: 'cart#checkout'
  post 'cart/add_product/:product_id', to: 'cart#add_product', as: :add_to_cart
  post 'cart/cart_destroy', to: 'cart#cart_destroy', as: :cart_destroy
  get 'cart/address', to: 'cart#address'
  post 'cart/add_address', to: 'cart#add_address', as: :add_address
  put 'cart/edit_address/:id', to: 'cart#edit_address', as: :edit_address
  get 'cart/billing', to: 'cart#billing'
  put 'cart/edit_cc/:id', to: 'cart#edit_cc', as: :edit_cc
  post 'cart/add_cc', to: 'cart#add_cc', as: :add_cc
  get 'cart/checkout', to: 'cart#checkout'

  resources :orders, only: :show

  resources :products, only: [:show, :index]

  get 'users/index', to: 'users#index'

  get 'users', to: 'users#show'

  get 'orders/:order_id', to: 'orders#show'

  # put 'orders/{:id}/cancel'


end
