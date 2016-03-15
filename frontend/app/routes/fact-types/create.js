import Ember from 'ember';

export default Ember.Route.extend ({
  model: function() {
    return Ember.Object.create ({
      factType: this.modelFor('fact_type'),
      factTypes: this.store.findAll('fact_type')
    });
  }
});
