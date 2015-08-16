Rails.application.routes.draw do
	mount EmberCLI::Engine => "ember-tests" if Rails.env.development?
	#http://localhost:3000/ember-tests/frontend

	root 'forums#index'

	##            Information              ##
	#########################################
	# get '/*path' => 'forums#index' || get '/*path', to: 'forums#index'
	# Does not work as it causes SyntaxError: Unexpected token < 
	# reported by ember.debug.js:31686
	#########################################
	##   Redirect all routes to Ember.js   ##
	
	# "Static routes"
	get '/login', to: 'forums#index'
	get '/about', to: 'forums#index'
	get '/privacy_info', to: 'forums#index'
	get '/legal_info', to: 'forums#index'
	# "Resource routes"
	get '/posts', to: 'forums#index'
	get '/posts/create', to: 'forums#index'
		get '/posts/:id', to: 'forums#index'
		get '/posts/:id/edit', to: 'forums#index'
	get '/post/:id/comment/:id', to: 'forums#index'
	get '/users', to: 'forums#index'
	get '/users/create', to: 'forums#index'
		get '/users/:id', to: 'forums#index'
		get '/users/:id/edit', to: 'forums#index'
	get '/genre/:id', to: 'forums#index'
	get '/admin_message/:id', to: 'forums#index'
	get '/fact_type/:id', to: 'forums#index'
	get '/topic/:id', to: 'forums#index'
	get '/categorie/:id', to: 'forums#index'
	get '/user/:id', to: 'forums#index'
	# Resource routes without ids
	get '/posts/:id/comments', to: 'forums#index'
	get '/genres', to: 'forums#index'
	get '/admin_messages', to: 'forums#index'
	get '/fact_types', to: 'forums#index'
	get '/topics', to: 'forums#index'
	get '/categories', to: 'forums#index'
	get '/users', to: 'forums#index'
	
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
