import Ember from "ember";
const { service } = Ember.inject;

export default Ember.Controller.extend ({
  application: Ember.inject.controller('application'),
  session: service('session'),
  title: "",
  text: "",
  fact_link: "",
  fictionLink: "",
  clientSideValidationComplete: false,
  changeTags: false,
  nextGenreID: Ember.computed('application.selectedGID', function() {
    return this.get('application.selectedGID');
  }),
  nextGenreName: Ember.computed('application.selectedGN', function() {
    return this.get('application.selectedGN');
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
    if(this.get('model.title').length < 10) {
      this.set('clientSideValidationComplete',false);
      return "Too short";
    }
    else {
      this.set('clientSideValidationComplete',true);
      return '';
    }
  }),
  verifyText: Ember.computed('model.text', function() {
    if(this.get('model.text').length < 10) {
      this.set('clientSideValidationComplete',false);
      return "10 Min Characters...";
    }
    else if(this.get('model.text').length > 2000) {
      this.set('clientSideValidationComplete',false);
      return "2000 Max Characters. Please revise your input!";
    }
    else {
      this.set('clientSideValidationComplete',true);
      var charsLeft = 2000 - this.get('model.text').length;
      return charsLeft + ' Characters left.';
    }
  }),
  verifyfactLink: Ember.computed('model.fact_link', function() {
    if(this.get('model.fact_link').length < 4) {
      this.set('clientSideValidationComplete',false);
      return "Past Complete URL";
    }
    else {
      this.set('clientSideValidationComplete',true);
      return '';
    }
  }),
  verifyFictionLink: Ember.computed('model.fiction_link', function() {
    if(this.get('model.fiction_link').length < 4) {
      this.set('clientSideValidationComplete',false);
      return "Past Complete URL";
    }
    else {
      this.set('clientSideValidationComplete',true);
      return '';
    }
  }),
  verifyGenre: Ember.computed('model.genreID', function() {
    if(this.get('model.genreID') === 0) {
      this.set('clientSideValidationComplete',false);
      return "Missing Genre";
    }
    else {
      this.set('clientSideValidationComplete',true);
      return '';
    }
  }),
  verifyFactType: Ember.computed('model.factTypeID', function() {
    if(this.get('model.factTypeID') === 0) {
      this.set('clientSideValidationComplete',false);
      return "Missing Fact Type";
    }
    else {
      this.set('clientSideValidationComplete',true);
      return '';
    }
  }),
  verifyCategory: Ember.computed('model.categoryID', function() {
    if(this.get('model.categoryID') === 0) {
      this.set('clientSideValidationComplete',false);
      return "Missing Category";
    }
    else {
      this.set('clientSideValidationComplete',true);
      return '';
    }
  }),
  verifyTopic: Ember.computed('model.topicID', function() {
    if(this.get('model.topicID') === 0) {
      this.set('clientSideValidationComplete',false);
      return "Missing Topic";
    }
    else {
      this.set('clientSideValidationComplete',true);
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
      if(this.get('clientSideValidationComplete')) {
        var post = this.get('content');
        if(this.get('changeTags') === true) {
          var store = this.store;
          if (this.get('nextCategoryID') !== 0) {
            post.set('category', store.peekRecord('category', this.get('nextCategoryID')));
          }
          if (this.get('nextTopicID') !== 0) {
            post.set('topic', store.peekRecord('topic', this.get('nextTopicID')));
          }
          if (this.get('nextGenreID') !== 0) {
            post.set('genre', store.peekRecord('genre', this.get('nextGenreID')));
          }
          if (this.get('nextFactTypeID') !== 0) {
            post.set('fact_type', store.peekRecord('fact_type', this.get('nextFactTypeID')));
          }
        }
        var controller = this;
        post.save().then(function() {
          controller.transitionToRoute('post', post);  
        }, function() {
          alert('failed to save post!');
        });
      }
      else {
        alert("(Client 402) Failed to save post... Check any warning messages (to the right of each textbox) otherwise contact support if you don't see any");
      }
    }
  }
});
