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

  // USER(S) ROUTES
  this.route('users', function(){
    this.route('create');
  });
  this.route('user', { path:'user/:user_id' }, function() {
    this.route('edit');
    this.route('posts'); // view all posts by x User
    this.route('comments'); // View all Comments by x User
  });


  /* See Issue #31
  // ADMIN MESSAGE(S) ROUTES
  this.route('adminMessages', function(){
    this.route('create');
  });
  this.route('adminMessage', { path:'adminMessage/:admin_message_id' }, function() {
    this.route('edit');
  });
  */
  // POST(S) ROUTES
  this.route('posts', function(){
    this.route('create');
  });
  this.route('post', { path:'post/:post_id' }, function() {
    this.route('edit');
    // POST COMMENTS(S) ROUTES
    this.route('comments', function(){
      this.route('create');
    });
    this.route('comment', { path:'comment/:comment_id' }, function() {
      // Comment EDIT has been merged into INDEX
      // POST INNER COMMENTS(S) ROUTES
      this.route('innerComments', function(){
        this.route('create');
      });
      this.route('innerComment', { path:'innerComment/:inner_comment_id' }, function() {
        // inner_comment EDIT has been merged into INDEX
      });
    });
  });

  // Fact Type(S) ROUTES
  this.route('factTypes', function(){
    this.route('create');
  });
  this.route('factType', { path:'factType/:factType_id' }, function() {
    this.route('edit');
  });

  // TOPIC(S) ROUTES
  this.route('topics', function(){
    this.route('create');
  });
  this.route('topic', { path:'topic/:topic_id' }, function() {
    this.route('edit');
  });

  // CATEGORY(S) ROUTES
  this.route('categories', function(){
    this.route('create');
  });
  this.route('category', { path:'category/:category_id' }, function() {
    this.route('edit');
  });

  // Footer related
  this.route('footer');
  this.route('legalInfo');
  this.route('privacyInfo');
  this.route('support');

  // 404 Handler
  this.route('not-found', { path: '/*wildcard' });
});

export default Router;
