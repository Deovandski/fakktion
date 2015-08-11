import DS from "ember-data";

DS.ActiveModelAdapter.reopen
({
	namespace: 'api/v1'
});

export default DS.ActiveModelAdapter.extend
({
	shouldReloadAll()
	{
		return false;
	}
});
