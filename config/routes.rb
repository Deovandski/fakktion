Rails.application.routes.draw do
	root 'forums#index'

	#Redirect all routes to Ember.js 
	## Could not find a more straight forward way to do it since Ember is supposed to handle
	## all frontend stuff...
	# "Static routes"
	get '/login', to: 'forums#index'
	get '/support', to: 'forums#index'
	get '/about', to: 'forums#index'
	get '/privacy_info', to: 'forums#index'
	get '/legal_info', to: 'forums#index'
	# "Resource routes"
	get '/posts/:id', to: 'forums#index'
	get '/posts/:id/comments/:id', to: 'forums#index'
	get '/genres/:id', to: 'forums#index'
	get '/admin_messages/:id', to: 'forums#index'
	get '/fact_types/:id', to: 'forums#index'
	get '/topics/:id', to: 'forums#index'
	get '/categories/:id', to: 'forums#index'
	get '/users/:id', to: 'forums#index'


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
