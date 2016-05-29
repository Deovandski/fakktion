import Ember from "ember";
const { service } = Ember.inject;

export default Ember.Controller.extend ({
  session: service('session'),
  sessionAccount: service('session-account'),
  application: Ember.inject.controller('application'),
  title: "",
  text: '',
  factLink: "",
  fictionLink: "",
  clientSideValidationComplete: false,
  verifyTitle: Ember.computed('title', function() {
    if(this.get('title').length < 10) {
      this.set('clientSideValidationComplete',false);
      return "Too short";
    }
    else {
      this.set('clientSideValidationComplete',true);
      return '';
    }
  }),
  verifyText: Ember.computed('text', function() {
    if(this.get('text').length < 10) {
      this.set('clientSideValidationComplete',false);
      return "10 Min Characters...";
    }
    else if(this.get('text').length > 1000) {
      this.set('clientSideValidationComplete',false);
      return "1000 Max Characters. Please revise your input!";
    }
    else {
      this.set('clientSideValidationComplete',true);
      var charsLeft = 1000 - this.get('text').length;
      
      return charsLeft + ' Characters left.';
    }
  }),
  verifyFactLink: Ember.computed('factLink', function() {
    if(this.get('factLink') !== '') {
      if(this.get('factLink').length < 8) {
        this.set("clientSideValidationComplete", false);
        return "Invalid URL";
      }
      else {
        this.set("clientSideValidationComplete", true);
        return "";
      }
    }
    else {
      this.set("clientSideValidationComplete",true);
      return "http(s)://www.example.com";
    }
  }),
  verifyFictionLink: Ember.computed('fictionLink', function() {
    if(this.get('fictionLink') !== '') {
      if(this.get('fictionLink').length < 8) {
        this.set("clientSideValidationComplete", false);
        return "Invalid URL";
      }
      else {
        this.set("clientSideValidationComplete", true);
        return "";
      }
    }
    else {
      this.set("clientSideValidationComplete",true);
      return "http(s)://www.example.com";
    }
  }),
  allTagsValid: Ember.computed('application.selectedGenre.id','application.selectedFactType.id', 'application.selectedCategory.id','application.selectedTopic.id',  function() {
    if(this.get('application.selectedGenre.id') > 0 && this.get('application.selectedFactType.id') > 0 && this.get('application.selectedCategory.id') > 0 && this.get('application.selectedTopic.id') > 0) {
      return true;
    }
    else {
      return false;
    }
  }),
  verifyGenre: Ember.computed('application.selectedGenre.id', function() {
    if(this.get('application.selectedGenre.id') > 0) {
      this.set('clientSideValidationComplete',true);
      return false;
    }
    else {
      this.set('clientSideValidationComplete',false);
      return true;
    }
  }),
  verifyFactType: Ember.computed('application.selectedFactType.id', function() {
    if(this.get('application.selectedFactType.id') > 0) {
      this.set('clientSideValidationComplete',true);
      return false;
    }
    else {
      this.set('clientSideValidationComplete',false);
      return true;
    }
  }),
  verifyCategory: Ember.computed('application.selectedCategory.id', function() {
    if(this.get('application.selectedCategory.id') > 0) {
      this.set('clientSideValidationComplete',true);
      return false;
    }
    else {
      this.set('clientSideValidationComplete',false);
      return true;
    }
  }),
  verifyTopic: Ember.computed('application.selectedTopic.id', function() {
    if(this.get('application.selectedTopic.id') > 0) {
      this.set('clientSideValidationComplete',true);
      return false;
    }
    else {
      this.set('clientSideValidationComplete',false);
      return true;
    }
  }),
  actions: {
    create: function() {
      if(this.get('clientSideValidationComplete') === true) {
        var store = this.store;
        var post = store.createRecord('post', {
          title: this.get('title'),
          text: this.get('text'),
          fact_link: this.get('factLink'),
          fiction_link: this.get('fictionLink'),
          hidden: false,
          softDelete: false,
          comments_count: 0,
          user: store.peekRecord('user', this.get('sessionAccount.user.id')),
          genre: store.peekRecord('genre', this.get('application.selectedGenre.id')),
          fact_type: store.peekRecord('fact_type', this.get('application.selectedFactType.id')),
          topic: store.peekRecord('topic', this.get('application.selectedTopic.id')),
          category: store.peekRecord('category', this.get('application.selectedCategory.id'))
        });
        var self = this;
        post.save().then(function() {
          self.set('title', '');
          self.set('text', '');
          self.set('factLink', '');
          self.set('fictionLink', '');
          self.transitionToRoute('post', post);
        }, function() {
          alert('Server Failure!');
        });
      }
      else {
        alert("Check any warning messages and try again! (Client Validation F)");
      }
    }
  }
});
