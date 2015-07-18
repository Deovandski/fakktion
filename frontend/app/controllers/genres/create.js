import Ember from "ember";

export default Ember.Controller.extend
({
  actions: {
    create: function() {
      var genre = this.store.createRecord('genre', {
        genreName: this.get('genreName'),
      });
      var self = this;
      genre.save().then(function() {
        console.log('genre created!');
        self.transitionTo('genre', genre);
        self.set('genreName', '');
      }, function() {
        alert('failed to create genre!');
      });
    }
  }
});
