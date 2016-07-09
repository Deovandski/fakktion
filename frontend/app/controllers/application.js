// Application Controller
import Ember from "ember";
const { service } = Ember.inject;

/* Abbreviations:
PDN: PostingDateNaming
------------------
CP: CategoryPartial
FTP: FactTypePartial
PDP: PostingDatePartial
------------------
CPV: Category Partial Visibility
FTPV: FactType Partial Visibility
PDPV: PostingDate Partial Visibility
*/
export default Ember.Controller.extend ({
  session:        service('session'),
  sessionAccount: service('session-account'),
  // Variables Section
  selectedFactType: null,
  selectedTopic: null,
  selectedCategory: null,
  selectedPDID: 0,
  selectedPDN: 'None',
  // Sidebar visibility can no longer be controlled.
  displayLeftSidebar: true,
  displayRightSidebar: true,
  exampleH5: "<h5>Header</h5><ul><li><i>Item 1</i></li><li><s>Item 2</s></li></ul>",
  exampleFontManipulation: 'Easy <b>way</b> to break lines with:<br>BR<br><a href="http://w3schools.com/html/html_basic.asp" target="_blank">HTML 101</a>',
  exampleOL: "<p>However, you can use p for paragraphs.</p><ol><li><label>Item 1</label></li><li>Item 2</li></ol>",
  exampleLineBreaker: "<br>",
  exampleH5_part1: "<h5>Header</h5>",
  exampleH5_part2: "<ul>",
  exampleH5_part3: "<li><i>Item 1</i></li>",
  exampleH5_part4: "<li><s>Item 2</s></li>",
  exampleH5_part5: "</ul>",
  exampleFontManipulation_part1: "Easy <b>way</b> to break lines with:<br>BR<br>",
  exampleFontManipulation_part2: '<a href="http://w3schools.com/html/html_basic.asp" target="_blank">HTML 101</a>',
  exampleOL_part1: "<p>However, you can use p for paragraphs.</p>",
  exampleOL_part2: "<ol>",
  exampleOL_part3: "<li><label>Item 1</label></li>",
  exampleOL_part4: "</li><li>Item 2</li>",
  exampleOL_part5: "</ol>",
  isBanned: Ember.computed('sessionAccount.user.reputation', function() {
    if (this.get('sessionAccount.user.reputation') < -100) {
      return true;
    } else {
      return false;
    }
  }),
  // Verify if the user is a Admin.
  isAdmin: Ember.computed('sessionAccount.user.is_admin', function() {
    if(this.get('sessionAccount.user.is_admin') === true) {
      return true;
    }
    else {
      return false;
    }
  }),
  // Tags Selected Boolean check.
  isFactTypeSelected: Ember.computed('selectedFactType', function() {
    if(this.get('selectedFactType') !== null) {
      return true;
    }
    else {
      return false;
    }
  }),
  isCategorySelected: Ember.computed('selectedCategory', function() {
    if(this.get('selectedCategory') !== null) {
      return true;
    }
    else {
      return false;
    }
  }),
  isTopicSelected: Ember.computed('selectedTopic', function() {
    if(this.get('selectedTopic') !== null && this.get('selectedTopic') !== 'invalid') {
      return true;
    }
    else {
      return false;
    }
  }),
  isPostingDateSelected: Ember.computed('selectedPDID', function() {
    if(this.get('selectedPDID') !== 0) {
      return true;
    }
    else {
      return false;
    }
  }),
  server422Watcher: Ember.computed('sessionAccount.server422', function() {
    if(this.get('sessionAccount.server422') === true) {
      console.log('422 | Refreshing in 300ms');
      Ember.run.later((function() {
        location.reload();
      }), 300);
    }
  }),
  actions: {
    //Set ID Tag Methods
    setCategory: function(category) {
      this.set('selectedCategory', category);
    },
    setFactType: function(factType) {
      this.set('selectedFactType', factType);
    },
    setTopic: function(topic) {
      this.set('selectedTopic', topic);
    },
    setPDID: function(varDayType, varDayName) {
      this.set('selectedPDID', varDayType);
      this.set('selectedPDN', varDayName);
    },
    clearFactType: function() {
      this.set('selectedFactType', null);
      this.send('clearPostDate');
    },
    clearCategory: function() {
      this.set('selectedCategory', null);
      this.send('clearTopic');
    },
    clearTopic: function() {
      this.set('selectedTopic', null);
    },
    clearPostDate: function() {
      this.set('selectedPDID', 0);
      this.set('selectedPDN', 'None');
    },
    goHome : function(){
      this.transitionToRoute('index');
    },
    goSearch : function(){
      this.transitionToRoute('users');
    },
    logout() {
      this.get('session').invalidate();
    }
  }
});
