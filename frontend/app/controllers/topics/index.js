import Ember from "ember";
const { service } = Ember.inject;

export default Ember.Controller.extend ({
  session:        service('session'),
  sessionAccount: service('session-account'),
  application: Ember.inject.controller('application'),
  searchingTag: Ember.computed('application.topicInputText', function() {
    if(this.get('application.topicInputText').length > 0 ){
      return true;
    }
    else{
      return false;
    }
  }),
  filteredTags: Ember.computed('application.topicInputText', function() {
    if(this.get('application.topicInputText') === '') {
      this.set('noTags', false);
      return this.get('model');
    }
    else{
        var rx = new RegExp(this.get('application.topicInputText').toLowerCase()
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
      this.set('application.topicInputText','');
    },
    setTopic: function(topic) {
      this.set('application.selectedTopic', topic);
      this.transitionToRoute('index');
    }
  }
});
