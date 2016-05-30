import Ember from "ember";
import moment from 'moment';
const { service } = Ember.inject;

export default Ember.Controller.extend ({
  session: service('session'),
  sessionAccount: service('session-account'),
  application: Ember.inject.controller('application'),
  expandInfo: false,
  expandTags: false,
  canEdit: Ember.computed('model.user_id', 'application.isAdmin', function() {
    if(this.get('session.secure.userId') === this.get('model.user.id')){
      return true;
    }
    else if(this.get('application.isAdmin') === true) {
      return true;
    }
    else {
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
      if (this.get('expandTags') === true){
        this.set('expandTags', false);
      }
      this.set('expandInfo', expandInfo);
    },
    setExpandTags: function(expandTags) {
      if (this.get('expandInfo') === true){
        this.set('expandInfo', false);
      }
      this.set('expandTags', expandTags);
    }
  }
});
