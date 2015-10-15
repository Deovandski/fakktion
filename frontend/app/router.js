import Ember from 'ember';
import config from './config/environment';

var Router = Ember.Router.extend
({
    location: config.locationType
});

Router.map(function()
{
  // Login related
  this.route('header');
  this.route('login', { path: '/login' });

  // Admin and Super User related
  this.route('adminPanel', { path: '/adminPanel' });
  this.route('superUserPanel', { path: '/superUserPanel' });

  // User
  this.resource('users', function(){
      this.resource('user', { path:'/:user_id' }, function()
      {
          this.route('edit');
          this.route('posts');
          this.route('comments');
      });
      this.route('create');
	});

  // Admin Messages
  this.resource('adminMessages', function(){
      this.resource('adminMessage', { path:'/:admin_message_id' }, function()
      {
          this.route('edit');
      });
      this.route('create');
	});

  // Posts
  this.resource('posts', function(){
      this.resource('post', { path:'/:post_id' }, function()
      {
          this.route('edit');
          // Comments
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

  // Genres
  this.resource('genres', function(){
      this.resource('genre', { path:'/:genre_id' }, function()
      {
          this.route('edit');
      });
      this.route('create');
	});

  // Fact Type
  this.resource('factTypes', function(){
      this.resource('factType', { path:'/:factType_id' }, function()
      {
          this.route('edit');
      });
      this.route('create');
	});

  // Topic
  this.resource('topics', function(){
      this.resource('topic', { path:'/:topic_id' }, function()
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
  this.route('adminMessages');
});

export default Router;
