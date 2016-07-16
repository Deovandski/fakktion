import Ember from "ember";
const { service } = Ember.inject;

export default Ember.Controller.extend({
  session: service('session'),
  sessionAccount: service('session-account'),
  application: Ember.inject.controller('application'),
  title: "",
  text: '',
  factLink: "",
  fictionLink: "",
  isBanned: Ember.computed('sessionAccount.user.reputation', function() {
    if (this.get('sessionAccount.user.reputation') < -250) {
      return true;
    } else {
      return false;
    }
  }),
  clientSideValidationComplete: false,
  verifyTitle: Ember.computed('title', function() {
    if (this.get('title').length < 1) {
      this.set('clientSideValidationComplete', false);
      return "Min 1 Char...";
    } else if (this.get('title').length > 100) {
      this.set('clientSideValidationComplete', false);
      return "Max 100 Chars.";
    } else {
      this.set('clientSideValidationComplete', true);
      return '';
    }
  }),
  verifyText: Ember.computed('text', function() {
    if (this.get('text').length < 1) {
      this.set('clientSideValidationComplete', false);
      return "1 Min Character...";
    } else if (this.get('text').length > 2000) {
      this.set('clientSideValidationComplete', false);
      return "2000 Max Characters. Please revise your input!";
    } else {
      this.set('clientSideValidationComplete', true);
      var charsLeft = 2000 - this.get('text').length;

      return charsLeft + ' Characters left.';
    }
  }),
  verifyFactLink: Ember.computed('factLink', function() {
    if (this.get('factLink') !== '') {
      if (this.get('factLink').length < 8) {
        this.set("clientSideValidationComplete", false);
        return "Invalid URL";
      } else if (this.get('factLink').length > 150) {
        this.set("clientSideValidationComplete", false);
        return "Max 150 Chars";
      } else {
        var rx = new RegExp("^(http|https|HTTP|HTTPS)://");
        var htmlString = this.get('factLink').match(rx);
        if (htmlString !== null) {
          this.set('clientSideValidationComplete', true);
          return '';
        } else {
          this.set('clientSideValidationComplete', false);
          return "URL missing HTTP:// or HTTPS://";
        }
      }
    } else {
      this.set("clientSideValidationComplete", true);
      return "http(s)://www.example.com";
    }
  }),
  verifyFictionLink: Ember.computed('fictionLink', function() {
    if (this.get('fictionLink') !== '') {
      if (this.get('fictionLink').length < 8) {
        this.set("clientSideValidationComplete", false);
        return "Invalid URL";
      } else if (this.get('fictionLink').length > 150) {
        this.set("clientSideValidationComplete", false);
        return "Max 150 Chars";
      } else {
        var rx = new RegExp("^(http|https|HTTP|HTTPS)://");
        var htmlString = this.get('fictionLink').match(rx);
        if (htmlString !== null) {
          this.set('clientSideValidationComplete', true);
          return '';
        } else {
          this.set('clientSideValidationComplete', false);
          return "URL missing HTTP:// or HTTPS://";
        }
      }
    } else {
      this.set("clientSideValidationComplete", true);
      return "http(s)://www.example.com";
    }
  }),
  allTagsValid: Ember.computed('application.selectedFactType.id', 'application.selectedCategory.id', 'application.selectedTopic.id', function() {
    if (this.get('application.selectedFactType.id') > 0 && this.get('application.selectedCategory.id') > 0 && this.get('application.selectedTopic.id') > 0) {
      return true;
    } else {
      return false;
    }
  }),
  verifyFactType: Ember.computed('application.selectedFactType.id', function() {
    if (this.get('application.selectedFactType.id') > 0) {
      this.set('clientSideValidationComplete', true);
      return false;
    } else {
      this.set('clientSideValidationComplete', false);
      return true;
    }
  }),
  verifyCategory: Ember.computed('application.selectedCategory.id', function() {
    if (this.get('application.selectedCategory.id') > 0) {
      this.set('clientSideValidationComplete', true);
      return false;
    } else {
      this.set('clientSideValidationComplete', false);
      return true;
    }
  }),
  verifyTopic: Ember.computed('application.selectedTopic.id', function() {
    if (this.get('application.selectedTopic.id') > 0) {
      this.set('clientSideValidationComplete', true);
      return false;
    } else {
      this.set('clientSideValidationComplete', false);
      return true;
    }
  }),
  actions: {
    create: function() {
      if (this.get('clientSideValidationComplete') === true) {
        var store = this.store;
        var post = store.createRecord('post', {
          title: this.get('title'),
          text: this.get('text'),
          fact_link: this.get('factLink'),
          fiction_link: this.get('fictionLink'),
          comments_count: 0,
          user: store.peekRecord('user', this.get('sessionAccount.user.id')),
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
          alert('Server rejected the attempt.');
        });
      } else {
        alert("Please check any outstanding warning message(s), and try again!");
      }
    }
  }
});
