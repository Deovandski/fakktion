import Ember from "ember";

export default Ember.Controller.extend
({
  actions: {
    create: function() {
      var post = this.store.createRecord('post', {
        user_id: this.get('session.currentUser.id'),
        title: this.get('postName'),
        text: this.get('text'),
        fact_link: this.get('fact_link'),
        fiction_link: this.get('fiction_link'),
        genre_id: 1,
        topic_id: 1,
        fact_type_id: 1,
        categorie_id: 1,
        hidden: false,
        softDelete: false,
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
