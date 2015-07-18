import Ember from "ember";

export default Ember.Controller.extend
({
  actions: {
    updateGenre: function() {
      var genre = this.get('content');
      genre.set('genreName', this.get('genreName'));
      var controller = this;
      genre.save().then(function() {
        console.log('Genre saved!');
        controller.transitionTo('genre', genre);
      }, function() {
        alert('failed to save genre!');
      });
    }
  }
});
