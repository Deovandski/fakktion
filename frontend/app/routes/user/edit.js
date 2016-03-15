/*jshint unused:false*/
// JSHINT unused:false due to a false postive on transitionTo.
import Ember from 'ember';
const { service } = Ember.inject;

export default Ember.Route.extend ({
  session: service('session'),
  sessionAccount: service('session-account'),
  model: function() {
    return Ember.Object.create ({
      user: this.modelFor('user'),
      users: this.store.findAll('user')
    });
  },
  afterModel(model, transition) {
    if (model.user.get('id') === this.get('sessionAccount.user.id')) {
      // Allow Editing
    }
    else{
      this.transitionTo('index');
    }
  }
});
