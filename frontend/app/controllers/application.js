// Application Controller
import Ember from 'ember';
const { service } = Ember.inject;

/* Abbreviations:
GID: Genre_id
CID: category_id
TID: topic_id
FTID: fact_type_id
------------------
GN: GenreName
CN: CategoryName
TN: Topicname
FTN: FactTypeName
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
  selectedGID: 0,
  selectedCID: 0,
  selectedTID: 0,
  selectedFTID: 0,
  selectedPDID: 0,
  selectedGN: 'None',
  selectedCN: 'None',
  selectedTN: 'None',
  selectedFTN: 'None',
  selectedPDN: 'None',
  topicInputText: '',
  showGP: true,
  showCP: true,
  showFTP: true,
  showPDP: true,
  // Paths to show central Panel and Sidebars Panels:
  centralPanelPaths: ['index',
  'posts.index', 'posts.create', 'post.edit',
  'genres.index', 'genres.create', 'genre.index', 'genre.edit',
  'topics.index', 'topics.create', 'topic.index', 'topic.edit',
  'factTypes.index', 'factTypes.create', 'factType.index', 'factType.edit'],
  sidebarsPanelPaths: ['index',
  'posts.index', 'posts.create', 'post.edit',
  'genres.index', 'genres.create', 'genre.index', 'genre.edit',
  'topics.index', 'topics.create', 'topic.index', 'topic.edit',
  'factTypes.index', 'factTypes.create', 'factType.index', 'factType.edit'],
  // Central Panel and Sidebars Visibility Boolean Check
  displayCentralPanel: Ember.computed('currentPath', function() {
    //console.log(this.get('currentPath'));
    if(this.get('centralPanelPaths').indexOf(this.get('currentPath')) !== -1) {
      return true;
    }
    else {
      return false;
    }
  }),
  displaySidebars: Ember.computed('currentPath', function(){
    if(this.get('sidebarsPanelPaths').indexOf(this.get('currentPath')) !== -1) {
      return true;
    }
    else {
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
  isGenreSelected: Ember.computed('selectedGID', function() {
    if(this.get('selectedGID') !== 0) {
      return true;
    }
    else {
      return false;
    }
  }),
  isFactTypeSelected: Ember.computed('selectedFTID', function() {
    if(this.get('selectedFTID') !== 0) {
      return true;
    }
    else {
      return false;
    }
  }),
  isCategorySelected: Ember.computed('selectedCID', function() {
    if(this.get('selectedCID') !== 0) {
      return true;
    }
    else {
      return false;
    }
  }),
  isTopicSelected: Ember.computed('selectedTID', function() {
    if(this.get('selectedTID') !== 0) {
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
  topicStatus: Ember.computed('selectedTN', function() {
    if(this.get('selectedTN') === 'None') {
      return '< Search or manage topics >';
    }
    else if(this.get('selectedTN') === 'Invalid') {
      return 'Not found. Check Settings >';
    }
    else if(this.get('selectedTN') === '') {
      return 'Search or manage topics!';
    }
    else {
      return 'Topic is selected!';
    }
  }),
  // Partials Visibility Boolean Check
  displayGP: Ember.computed('showGP', function() {
    if(this.get('showGP') === true) {
      return true;
    }
    else {
      return false;
    }
  }),
  displayCP: Ember.computed('showCP', function() {
    if(this.get('showCP') === true) {
      return true;
    }
    else {
      return false;
    }
  }),
  displayFTP: Ember.computed('showFTP', function() {
    if(this.get('showFTP') === true) {
      return true;
    }
    else {
      return false;
    }
  }),
  displayPDP: Ember.computed('showPDP', function() {
    if(this.get('showPDP') === true) {
      return true;
    }
    else {
      return false;
    }
  }),
  actions: {
    //Set ID Tag Methods
    setGID: function(genre) { 
      this.set('selectedGID', genre.id);
      this.set('selectedGN', genre.get('name'));
    },
    setCID: function(category) { 
      this.set('selectedCID', category.id);
      this.set('selectedCN', category.get('name'));
    },
    setFTID: function(factType) { 
      this.set('selectedFTID', factType.id);
      this.set('selectedFTN', factType.get('name'));
    },
    setTID: function() {
      if(this.get('topicInputText') !== '') {  
        var possibleTopic = this.model.get('topics').findBy('name', this.get('topicInputText').toLowerCase());
        if(possibleTopic === undefined) {
          this.set('selectedTN', 'Invalid');
          this.set('selectedTID', 0);
        }
        else {  
          this.set('selectedTID', possibleTopic.id);
          this.set('selectedTN', possibleTopic.get('name'));
        }
      }
      else {
        this.set('selectedTN', '');
        this.set('selectedTID', 0);
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
    //Set Partial Visibility Methods
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
    //Clear Tag Methods
    clearGenre: function() { 
      this.set('selectedGID', 0);
      this.set('selectedGN', 'None');
    },
    clearFactType: function() { 
      this.set('selectedFTID', 0);
      this.set('selectedFTN', 'None');
    },
    clearCategory: function() { 
      this.set('selectedCID', 0);
      this.set('selectedCN', 'None');
    },
    clearTopic: function() { 
      this.set('selectedTID', 0);
      this.set('selectedTN', 'None');
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
