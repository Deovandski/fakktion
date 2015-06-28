import DS from "ember-data";
import $ from 'jquery';

// Override the default adapter with the `DS.ActiveModelAdapter` with
DS.RESTAdapter.reopen({
  namespace: 'api/v1'
});

export default DS.ActiveModelAdapter.extend({
  headers: {
    "X-CSRF-Token": $('meta[name="csrf-token"]').attr('content')
  }
});
