/*jshint unused:false*/
// JSHINT unused:false due to a false postive on transitionTo.
import Ember from 'ember';
const { service } = Ember.inject;

export default Ember.Route.extend ({
  session: service('session'),
  sessionAccount: service('sessionAccount'),
  afterModel(model, transition) {
    if ( parseInt(model.get('user_id')) !==  parseInt(this.get('sessionAccount.user.id'))) {
      console.log(model.get('user_id'));
      console.log(this.get('sessionAccount.user.id'));
      this.transitionTo('index');
    }
  }
});
