import Ember from "ember";
const { service } = Ember.inject;

export default Ember.Controller.extend({
  application: Ember.inject.controller('application'),
  session: service('session'),
  sessionAccount: service('session-account'),
  clientSideValidationComplete: false,
  changeTags: false,
  isBanned: Ember.computed('sessionAccount.user.reputation', function() {
    if (this.get('sessionAccount.user.reputation') < -250) {
      return true;
    } else {
      return false;
    }
  }),
  nextFactTypeID: Ember.computed('application.selectedFTID', function() {
    return this.get('application.selectedFTID');
  }),
  nextFactTypeName: Ember.computed('application.selectedFTN', function() {
    return this.get('application.selectedFTN');
  }),
  nextCategoryID: Ember.computed('application.selectedCID', function() {
    return this.get('application.selectedCID');
  }),
  nextCategoryName: Ember.computed('application.selectedCN', function() {
    return this.get('application.selectedCN');
  }),
  nextTopicID: Ember.computed('application.selectedTID', function() {
    return this.get('application.selectedTID');
  }),
  nextTopicName: Ember.computed('application.selectedTN', function() {
    return this.get('application.selectedTN');
  }),
  verifyTitle: Ember.computed('model.title', function() {
    if (this.get('model.title').length < 1) {
      this.set('clientSideValidationComplete', false);
      return "Min 1 char";
    } else if (this.get('model.title').length > 100) {
      this.set('clientSideValidationComplete', false);
      return "Max 100 Chars.";
    } else {
      this.set('clientSideValidationComplete', true);
      return '';
    }
  }),
  verifyText: Ember.computed('model.text', function() {
    if (this.get('model.text').length < 1) {
      this.set('clientSideValidationComplete', false);
      return "1 Min Character...";
    } else if (this.get('model.text').length > 2000) {
      this.set('clientSideValidationComplete', false);
      return "2000 Max Characters. Please revise your input!";
    } else {
      this.set('clientSideValidationComplete', true);
      var charsLeft = 2000 - this.get('model.text').length;
      return charsLeft + ' Characters left.';
    }
  }),
  verifyFactLink: Ember.computed('model.fact_link', function() {
    if (this.get('model.fact_link').length < 4) {
      this.set('clientSideValidationComplete', false);
      return "Past Complete URL";
    } else if (this.get('model.fact_link').length > 150) {
      this.set("clientSideValidationComplete", false);
      return "Max 150 Chars";
    } else {
      var rx = new RegExp("^(http|https|HTTP|HTTPS)://");
      var htmlString = this.get('model.fact_link').match(rx);
      if (htmlString !== null) {
        this.set('clientSideValidationComplete', true);
        return '';
      } else {
        this.set('clientSideValidationComplete', false);
        return "URL missing HTTP:// or HTTPS://";
      }
    }
  }),
  verifyFictionLink: Ember.computed('model.fiction_link', function() {
    if (this.get('model.fiction_link').length < 4) {
      this.set('clientSideValidationComplete', false);
      return "Past Complete URL";
    } else if (this.get('model.fiction_link').length > 150) {
      this.set("clientSideValidationComplete", false);
      return "Max 150 Chars";
    } else {
      var rx = new RegExp("^(http|https|HTTP|HTTPS)://");
      var htmlString = this.get('model.fiction_link').match(rx);
      if (htmlString !== null) {
        this.set('clientSideValidationComplete', true);
        return '';
      } else {
        this.set('clientSideValidationComplete', false);
        return "URL missing HTTP:// or HTTPS://";
      }
    }
  }),
  verifyFactType: Ember.computed('model.factTypeID', function() {
    if (this.get('model.factTypeID') === 0) {
      this.set('clientSideValidationComplete', false);
      return "Missing Fact Type";
    } else {
      this.set('clientSideValidationComplete', true);
      return '';
    }
  }),
  verifyCategory: Ember.computed('model.categoryID', function() {
    if (this.get('model.categoryID') === 0) {
      this.set('clientSideValidationComplete', false);
      return "Missing Category";
    } else {
      this.set('clientSideValidationComplete', true);
      return '';
    }
  }),
  verifyTopic: Ember.computed('model.topicID', function() {
    if (this.get('model.topicID') === 0) {
      this.set('clientSideValidationComplete', false);
      return "Missing Topic";
    } else {
      this.set('clientSideValidationComplete', true);
      return '';
    }
  }),
  actions: {
    setChangeTags: function(varBoolean) {
      this.set('changeTags', varBoolean);
    },
    cancelChanges: function() {
      this.get('model').rollbackAttributes();
      this.transitionToRoute('post', this.get('model'));
    },
    update: function() {
      if (this.get('clientSideValidationComplete')) {
        var post = this.get('content');
        if (this.get('changeTags') === true) {
          var store = this.store;
          if (this.get('nextCategoryID') !== 0) {
            post.set('category', store.peekRecord('category', this.get('nextCategoryID')));
          }
          if (this.get('nextTopicID') !== 0) {
            post.set('topic', store.peekRecord('topic', this.get('nextTopicID')));
          }
          if (this.get('nextFactTypeID') !== 0) {
            post.set('fact_type', store.peekRecord('fact_type', this.get('nextFactTypeID')));
          }
        }
        var controller = this;
        post.save().then(function() {
          controller.transitionToRoute('post', post);
        }, function() {
          alert('Server rejected the attempt.');
        });
      } else {
        alert("Please check any outstanding warning message(s), and try again!");
      }
    }
  }
});
