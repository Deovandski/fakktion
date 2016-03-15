import Ember from 'ember';

export default Ember.Route.extend ({
  model: function() {
    return Ember.Object.create ({
      genre: this.modelFor('genre'),
      genres: this.store.findAll('genre')
    });
  }
});
