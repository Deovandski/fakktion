import Ember from "ember";
const { service } = Ember.inject;

export default Ember.Controller.extend({
  session: service('session'),
  sessionAccount: service('session-account'),
  topicInputText: "",
  isBanned: Ember.computed('sessionAccount.user.reputation', function() {
    if (this.get('sessionAccount.user.reputation') < -100) {
      return true;
    } else {
      return false;
    }
  }),
  searchingTag: Ember.computed('topicInputText', function() {
    if (this.get('topicInputText').length > 0) {
      return true;
    } else {
      return false;
    }
  }),
  filteredTags: Ember.computed('topicInputText', function() {
    if (this.get('topicInputText') === '') {
      this.set('noTags', false);
      return this.get('model');
    } else {
      var rx = new RegExp(this.get('topicInputText').toLowerCase());
      var filteredTags = this.model.filter(function(tag) {
        return tag.get('name').match(rx);
      });
      if (filteredTags.length > 0) {
        this.set('noTags', false);
        return filteredTags;
      } else {
        this.set('noTags', true);
        return null;
      }
    }
  }),
  actions: {
    clearTagSearchText: function() {
      this.set('topicInputText', '');
    }
  }
});
