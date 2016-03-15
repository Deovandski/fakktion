import Ember from 'ember';

export default Ember.Route.extend ({
  model: function(params) {
    return this.store.find('admin_message', params.admin_message_id);
  }
});
