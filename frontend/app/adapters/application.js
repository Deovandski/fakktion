import DS from "ember-data";

// Override the default adapter with the `DS.ActiveModelAdapter` with
DS.RESTAdapter.reopen({
  namespace: 'api/v1'
});

export default DS.ActiveModelAdapter.extend({
});
