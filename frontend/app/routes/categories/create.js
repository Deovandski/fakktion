import Ember from 'ember';
const { service } = Ember.inject;

export default Ember.Route.extend ({
  session: service('session'),
  sessionAccount: service('sessionAccount'),
  model: function() {
    return Ember.Object.create ({
      category: this.modelFor('category'),
      categories: this.store.findAll('category')
    });
  }
});
