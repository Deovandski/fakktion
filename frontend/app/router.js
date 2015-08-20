import Ember from 'ember';
import config from './config/environment';

var Router = Ember.Router.extend
({
	location: config.locationType
});

Router.map(function()
{
	//Login related
	this.route('header');
	this.route('login', { path: '/login' });

	//User
	this.resource('users', function(){
		this.resource('user', { path:'/:user_id' }, function()
		{
			this.route('edit');
			this.route('posts');
			this.route('comments');
		});
		this.route('create');
	});

	//Posts
	this.resource('posts', function(){
		this.resource('post', { path:'/:post_id' }, function()
		{
			this.route('edit');
			//Comments
			this.resource('comments', function(){
				this.resource('comment', { path:'/:comment_id' }, function()
				{
					this.route('edit');
				});
				this.route('create');
			});
		});
		this.route('create');
	});
	
	//Genres
	this.resource('genres', function(){
		this.resource('genre', { path:'/:genre_id' }, function()
		{
			this.route('edit');
		});
		this.route('create');
	});

	//Categories
	this.resource('categories', function(){
		this.resource('category', { path:'/:_id' }, function()
		{
			this.route('edit');
		});
		this.route('create');
	});

	// Posting Dates
	this.resource('postingDates', function(){
		this.resource('postingDate', { path:'/:_id' }, function()
		{
			this.route('edit');
		});
		this.route('create');
	});

	//Fact Type
	this.resource('factTypes', function(){
		this.resource('factType', { path:'/:_id' }, function()
		{
			this.route('edit');
		});
		this.route('create');
	});

	//Topic
	this.resource('topics', function(){
		this.resource('topics', { path:'/:_id' }, function()
		{
			this.route('edit');
		});
		this.route('create');
	});
	
	// Footer related
	this.route('footer');
	this.route('about');
	this.route('legal_info');
	this.route('privacy_info');
	this.route('support');
	this.route('about');
});

export default Router;
