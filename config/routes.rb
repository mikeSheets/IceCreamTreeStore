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

  resources :orders, only: :show

  resources :products, only: [:show, :index]

  get 'users/index', to: 'users#index'

  get 'users', to: 'users#show'

  get 'orders/:order_id', to: 'orders#show'

  # put 'orders/{:id}/cancel'



  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
