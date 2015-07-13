import Ember from 'ember';
import config from './config/environment';

var Router = Ember.Router.extend({
  location: config.locationType
});

Router.map(function() {
	//Login related
   this.route('header');
   this.route('login', { path: '/login' });

	//Main related
	this.route('posts', function() {
	   this.route('new');
	});
	this.route('post', {path: 'post/:post_id'}, function() {
		this.route('show');
		this.route('edit');
	});
   this.route('genres');
   this.route('genre', { path: '/genres/:id' });
   this.route('categories');
   this.route('categorie', { path: '/categories/:id' });
   this.route('postingDates');
   this.route('postingDate', { path: '/postingDates/:id' });
   this.route('factTypes');
   this.route('factType', { path: '/factTypes/:id' });

	// Footer related
   this.route('footer');
   this.route('about');
   this.route('legal_info');
   this.route('privacy_info');
   this.route('support');
   this.route('about');
});

export default Router;
