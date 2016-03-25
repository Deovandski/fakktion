import Ember from 'ember';

export default Ember.Route.extend ({
  model(params) {
    return this.store.findRecord('post', params.post_id);
  },
  setupController: function(controller, model) {
    model.incrementProperty('views_count');
    model.save;
  }
});
