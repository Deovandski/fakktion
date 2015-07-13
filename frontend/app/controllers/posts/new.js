import Ember from "ember";

export default Ember.Controller.extend
({
  actions: {
    createPost: function() {
      var post = this.store.createRecord('post', {
        postName: this.get('postName')
      });
      var self = this;
      post.save().then(function() {
        console.log('post created!');
        self.transitionTo('post', post);
        self.set('postName', '');
      }, function() {
        alert('failed to create post!');
      });
    }
  }
});
