import Ember from "ember";
import moment from 'moment';
const { service } = Ember.inject;

export default Ember.Controller.extend({
  sessionAccount: service('session-account'),
  application: Ember.inject.controller('application'),
  expandInfo: false,
  expandTags: false,
  isBanned: Ember.computed('sessionAccount.user.reputation', function() {
    if (this.get('sessionAccount.user.reputation') < -250) {
      return true;
    } else {
      return false;
    }
  }),
  canEdit: Ember.computed('model.user.id', 'sessionAccount.user.id', function() {
    if (this.get('sessionAccount.user.id') === this.get('model.user.id')) {
      return true;
    } else {
      return false;
    }
  }),
  updatedDate: Ember.computed('model.updated_at', function() {
    return moment(this.get("model.updated_at")).format('L');
  }),
  createdDate: Ember.computed('model.created_at', function() {
    return moment(this.get("model.created_at")).format('L');
  }),
  actions: {
    //Set ID Tag Methods
    setExpandInfo: function(expandInfo) {
      if (this.get('expandTags') === true) {
        this.set('expandTags', false);
      }
      this.set('expandInfo', expandInfo);
    },
    setExpandTags: function(expandTags) {
      if (this.get('expandInfo') === true) {
        this.set('expandInfo', false);
      }
      this.set('expandTags', expandTags);
    }
  }
});
