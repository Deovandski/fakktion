Rails.application.routes.draw do

  resources :admin_messages

  resources :posts

  resources :comments

  resources :fact_types

  resources :topics

  resources :categories

  resources :fact_postings

  resources :genres

  root 'forums#index'
  
  resources :users

  resource :session, :profile
  
  match 'code_sample', to: 'code_samples#index', via: [:get]
  match 'about', to: 'about#index', via: [:get]
  match 'legal_info', to: 'legal_info#index', via: [:get]
  match 'support', to: 'support#index', via: [:get]
  match 'privacy_info', to: 'privacy_info#index', via: [:get]
  match "clear_info", to: "users#clear_info", as: :clear_info, via: :post
  
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
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
