import Ember from 'ember';
import config from './config/environment';

var Router = Ember.Router.extend ({
	location: config.locationType
});

/* ROUTING INFO
 * Dogs (View all dogs or create one)
 * Dog (View, edit or delete info pertaining to a doge.)
 * Index routes with dynamic slugs (dog_id) needs to be properly identified...
 */
Router.map(function() {
	// Login related
	this.route('header');
	this.route('login', { path: '/login' });

	// Admin and Super User related
	this.route('adminPanel', { path: '/adminPanel' });
	this.route('superUserPanel', { path: '/superUserPanel' });

	// USER(S) ROUTES
	this.route('users', function(){
		this.route('create');
	});
	this.route('user', function() {
		this.route('index', { path:'/:user_id' });
		this.route('edit');
		this.route('posts'); // view all posts by x User
		this.route('comments'); // View all Comments by x User
	});

	// ADMIN MESSAGE(S) ROUTES
	this.route('adminMessages', function(){
		this.route('create');
	});
	this.route('adminMessage', function() {
		this.route('index', { path:'/:admin_message_id' });
		this.route('edit');
	});

	// POST(S) ROUTES
	this.route('posts', function(){
		this.route('create');
	});
	this.route('post', function() {
		this.route('index', { path:'/:post_id' });
		this.route('edit');
		// POST COMMENTS(S) ROUTES
		this.route('comments', function(){
			this.route('create');
		});
		this.route('comment', function() {
			this.route('index', { path:'/:comment_id' });
			this.route('edit');
		});
	});

	// GENRE(S) ROUTES
	this.route('genres', function(){
		this.route('create');
	});
	this.route('genre', function(){
		this.route('index', { path:'/:genre_id' });
		this.route('edit');
	});
	
	// Fact Type(S) ROUTES
	this.route('factTypes', function(){
		this.route('create');
	});
	this.route('factType', function(){
		this.route('index', { path:'/:factType_id' });
		this.route('edit');
	});
	
	// TOPIC(S) ROUTES
	this.route('topics', function(){
		this.route('create');
	});
	this.route('topic', function() {
		this.route('index', { path:'/:topic_id' });
		this.route('edit');
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
