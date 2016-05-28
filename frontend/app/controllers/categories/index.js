import Ember from "ember";
const { service } = Ember.inject;

export default Ember.Controller.extend ({
  session:        service('session'),
  sessionAccount: service('session-account'),
  application: Ember.inject.controller('application'),
  tagSearchText: "",
  searchingTag: Ember.computed('application.categoryInputText', function() {
    if(this.get('application.categoryInputText').length > 0 ){
      return true;
    }
    else{
      return false;
    }
  }),
  filteredTags: Ember.computed('application.categoryInputText', function() {
    if(this.get('application.categoryInputText') === '') {
      this.set('noTags', false);
      return this.get('model');
    }
    else{
        var rx = new RegExp(this.get('application.categoryInputText').toLowerCase()
      );
      var filteredTags = this.model.filter(function(tag) {
        return tag.get('name').match(rx);
      });
      if (filteredTags.length > 0) {
        this.set('noTags', false);
        return filteredTags;
      }
      else {
        this.set('noTags', true);
        return null;
      }
    }
  }),
  actions: {
  clearTagSearchText: function() {
    this.set('application.categoryInputText','');
  }
  }
});
