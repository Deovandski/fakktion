/*jshint unused:false*/
// JSHINT unused:false due to a false postive on transitionTo.
import Ember from 'ember';
import moment from 'moment';
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
  setupController: function(controller, model) {
    controller.set('model', model);
    var month = moment(model.user.get('date_of_birth')).format('MM');
    controller.set('dateOfBirth_month', month);
    var day = moment(model.user.get('date_of_birth')).format('DD');
    controller.set('dateOfBirth_day', day);
    var year = moment(model.user.get('date_of_birth')).format('YYYY');
    controller.set('dateOfBirth_year', year);
  },
  afterModel(model, transition) {
    if (model.user.get('id') !== this.get('sessionAccount.user.id')) {
      this.transitionTo('index');
    }
  }
});
