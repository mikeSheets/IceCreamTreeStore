Rails.application.routes.draw do
  devise_for :users

  root 'home#index'

  namespace 'admin' do
    resources :products
    resources :orders
  end

  namespace :api do 
    namespace :v1 do 
      resources :orders do 
        get 'cart', on: :collection, to: 'orders#get_cart'
        put 'update', on: :member
      end
      resources :products do
        post 'add_product', on: :member
      end
      resources :order_items do
        post 'create', on: :member
      end
      resources :addresses, only: [:create, :update]
      resources :states, only: :index
      resources :credit_cards, only: [:create, :update]
    end
  end

  resources :orders, only: :show
  resources :products, only: [:show, :index]

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
  get 'checkout', to: 'checkout#index'
  get 'account', to: 'home#account', as: :account
  get 'users/index', to: 'users#index'
  get 'users', to: 'users#show'
  get 'orders/:order_id', to: 'orders#show'
end