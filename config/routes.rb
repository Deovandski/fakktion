# Router
Rails.application.routes.draw do

	mount_ember_app :frontend, to: "/"

	# Devise
	devise_for :users, controllers: {sessions: 'sessions'}

	# API Routes
	namespace :api do
		namespace :v1 do
			resources :admin_messages
			resources :posts
			resources :comments
			resources :inner_comments
			resources :fact_types
			resources :topics
			resources :categories
			resources :genres
			resources :users
			resources :tokens, only: [:create]
		end
	end
end
