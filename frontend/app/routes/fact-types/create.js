import Ember from "ember";
const { service } = Ember.inject;

export default Ember.Route.extend({
  session: service('session'),
  sessionAccount: service('sessionAccount'),
  model: function() {
    return Ember.Object.create({
      factType: this.modelFor('factType'),
      factTypes: this.store.findAll('factType')
    });
  }
});
