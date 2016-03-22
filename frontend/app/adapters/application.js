// Adapter
import DS from "ember-data";
import Ember from "ember";
import ENV from "../config/environment";
import DataAdapterMixin from 'ember-simple-auth/mixins/data-adapter-mixin';


export default DS.JSONAPIAdapter.extend (DataAdapterMixin,{
  // Namespace.
  namespace: 'api/v1',
  authorizer: 'authorizer:devise',

  // if your rails app is on a different port from your ember app
  // this can be helpful for development.
  // in production, the host for both rails and ember should be the same.
  host: ENV.host,

  // allows queries to be sent along with a findRecord
  // hopefully Ember / EmberData will soon have this built in
  // ember-data issue tracked here:
  // https://github.com/emberjs/data/issues/3596
  urlForFindRecord(id, modelName, snapshot) {
    let url = this._super(...arguments);
    let query = Ember.get(snapshot, 'adapterOptions.query');
    if(query) {
      url += '?' + Ember.$.param(query);
    }
    return url;
  },
  // allows the multiword paths in urls to be underscored
  pathForType: function(type) {
    var underscored = Ember.String.underscore(type);
    return Ember.String.pluralize(underscored);
  },
  shouldReloadAll() {
    return true;
  },
  shouldBackgroundReloadRecord() {
    return true;
  }
});
