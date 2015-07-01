Rails.application.routes.draw do
	root 'forums#index'
	devise_for :users, controllers: {sessions: 'sessions'}

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
		end
	end
end
