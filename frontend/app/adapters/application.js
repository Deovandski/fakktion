import DS from "ember-data";

// Override the default adapter with the `DS.ActiveModelAdapter` with
DS.ActiveModelAdapter.reopen({
  namespace: 'api/v1'
});

export default DS.ActiveModelAdapter.extend({
	shouldReloadAll() { return false; }
});
