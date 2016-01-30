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
  this.route('users', function(){
      this.route('user', { path:'/:user_id' }, function()
      {
          this.route('edit');
          this.route('posts');
          this.route('comments');
      });
      this.route('create');
	});

  // Admin Messages
  this.route('adminMessages', function(){
      this.route('adminMessage', { path:'/:admin_message_id' }, function()
      {
          this.route('edit');
      });
      this.route('create');
	});

  // Posts
  this.route('posts', function(){
      this.route('post', { path:'/:post_id' }, function()
      {
          this.route('edit');
          // Comments
          this.route('comments', function(){
              this.route('comment', { path:'/:comment_id' }, function()
              {
                  this.route('edit');
              });
              this.route('create');
          });
      });
      this.route('create');
	});

  // Genres
  this.route('genres', function(){
      this.route('genre', { path:'/:genre_id' }, function()
      {
          this.route('edit');
      });
      this.route('create');
	});

  // Fact Type
  this.route('factTypes', function(){
      this.route('factType', { path:'/:factType_id' }, function()
      {
          this.route('edit');
      });
      this.route('create');
	});

  // Topic
  this.route('topics', function(){
      this.route('topic', { path:'/:topic_id' }, function()
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
