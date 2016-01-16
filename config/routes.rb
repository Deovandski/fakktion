# Router
Rails.application.routes.draw do

	mount EmberCLI::Engine => "ember-tests" if Rails.env.development?
	#http://localhost:3000/ember-tests/frontend

  	mount_ember_app :frontend, to: "/", controller: "application"

	# Devise
	devise_for :users, controllers: {sessions: 'sessions'}

	# API Routes
	namespace :api do
		namespace :v1 do
			resources :admin_messages
			resources :posts
			resources :comments
			resources :fact_types
			resources :topics
			resources :categories
			resources :genres
			resources :users
			get :csrf, to: 'csrf#index'
		end
	end
end
