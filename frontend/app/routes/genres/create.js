import Ember from 'ember';
const { service } = Ember.inject;

export default Ember.Route.extend ({
  session: service('session'),
  sessionAccount: service('sessionAccount'),
  model: function() {
    return Ember.Object.create ({
      genre: this.modelFor('genre'),
      genres: this.store.findAll('genre')
    });
  }
});
