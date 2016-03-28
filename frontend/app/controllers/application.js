// Application Controller
import Ember from 'ember';
const { service } = Ember.inject;

/* Abbreviations:
PDN: PostingDateNaming
------------------
GP: GenrePartial
CP: CategoryPartial
FTP: FactTypePartial
PDP: PostingDatePartial
------------------
GPV: Genres Partial Visibility
CPV: Category Partial Visibility
FTPV: FactType Partial Visibility
PDPV: PostingDate Partial Visibility
*/
export default Ember.Controller.extend ({
  session:        service('session'),
  sessionAccount: service('session-account'),
  // Variables Section
  selectedGenre: null,
  selectedFactType: null,
  selectedTopic: null,
  selectedCategory: null,
  selectedPDID: 0,
  selectedPDN: 'None',
  topicInputText: '',
  showGP: true,
  showCP: true,
  showFTP: true,
  showPDP: true,
  displayCentralPanel:true,
  displayLeftSidebar: true,
  displayRightSidebar: true,
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
  isGenreSelected: Ember.computed('selectedGenre', function() {
    if(this.get('selectedGenre') !== null) {
      return true;
    }
    else {
      return false;
    }
  }),
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
  isPostDateSelected: Ember.computed('selectedPDID', function() {
    if(this.get('selectedPDID') !== 0) {
      return true;
    }
    else {
      return false;
    }
  }),
  topicStatus: Ember.computed('selectedTopic', function() {
    if(this.get('selectedTopic') !== null && this.get('selectedTopic') !== 'invalid') {
      return 'Topic is selected!';
    }
    else if(this.get('selectedTopic') === 'invalid') {
      return 'Not found. Check below:';
    }
    else {
      return '< Search or manage topics >';
    }
  }),
  actions: {
    //Set ID Tag Methods
    setGenre: function(genre) { 
      this.set('selectedGenre', genre);
    },
    setCategory: function(category) { 
      this.set('selectedCategory', category);
    },
    setFactType: function(factType) { 
      this.set('selectedFactType', factType);
    },
    setTopic: function() {
      if(this.get('topicInputText') !== '') {  
        var possibleTopic = this.model.get('topics').findBy('name', this.get('topicInputText').toLowerCase());
        if(possibleTopic === undefined) {
          this.set('selectedTopic', 'invalid');
          this.transitionToRoute('topics');
        }
        else {  
          this.set('selectedTopic', possibleTopic);
        }
      }
      else {
      }
    },
    setPDID: function(varDayType) { 
      this.set('selectedPDID', varDayType);
      if(varDayType === 1){
        this.set('selectedPDN','Today');
      }
      else if(varDayType === 2) {
        this.set('selectedPDN','Yesterday');
      }
      else if(varDayType === 3) {
        this.set('selectedPDN','Past Week');
      }
      else if(varDayType === 4) {
        this.set('selectedPDN','Past Month');
      }
      else if(varDayType === 5) {
        this.set('selectedPDN','Past 6 Months');
      }
      else if(varDayType=== 6) {
        this.set('selectedPDN','Past Year');
      }
      else {
        this.set('selectedPDN','None');
      }
    },
    // Panel Controls
    setGPV: function(varBoolean) { 
      this.set('showGP', varBoolean);
    },
    setCPV: function(varBoolean) { 
      this.set('showCP', varBoolean);
    },
    setFTPV: function(varBoolean) { 
      this.set('showFTP', varBoolean);
    },
    setPDPV: function(varBoolean) { 
      this.set('showPDP', varBoolean);
    },
    toggleCentralPanel: function() {
      this.toggleProperty('displayCentralPanel');
    },
    toggleLeftSidebar: function() {
      this.toggleProperty('displayLeftSidebar');
    },
    toggleRightSidebar: function() {
      this.toggleProperty('displayRightSidebar');
    },
    //Clear Tag Methods
    clearGenre: function() { 
      this.set('selectedGenre', null);
    },
    clearFactType: function() { 
      this.set('selectedFactType', null);
    },
    clearCategory: function() { 
      this.set('selectedCategory', null);
    },
    clearTopic: function() { 
      this.set('selectedTopic', null);
      this.set('topicInputText', '');
    },
    clearPostDate: function() { 
      this.set('selectedPDID', 0);
      this.set('selectedPDN', 'None');
    },
    logout() {
      this.get('session').invalidate();
    }
  }
});
