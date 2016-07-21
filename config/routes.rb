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
  post 'cart/cart_destroy', to: 'cart#cart_destroy', as: :cart_destroy
  get 'cart/billing', to: 'cart#billing'
  get 'checkout', to: 'checkout#index'
  get 'account', to: 'home#account', as: :account
  get 'orders/:order_id', to: 'orders#show'
  get 'users/index', to: 'users#index'
  get 'users', to: 'users#show'
end