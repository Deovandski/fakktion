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
  factTypeInputText: '',
  genreInputText: '',
  categoryInputText: '',
  showGP: true,
  showCP: true,
  showFTP: true,
  showPDP: true,
  displayCentralPanel:true,
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
  defaultCategories: Ember.computed.filter('model.categories', function(category, index) {
      console.log('DEBUG --CT1 - Categories');
      return (index < 10);
  }),
  defaultGenres: Ember.computed.filter('model.genres', function(genre, index) {
      console.log('DEBUG --CT1 - Genres');
      return (index < 10);
  }),
  defaultFactTypes: Ember.computed.filter('model.factTypes', function(factType, index) {
      console.log('DEBUG --CT1 - Fact Types');
      return (index < 10);
  }),
  filteredCategories: Ember.computed('categoryInputText', function() {
    console.log('DEBUG --CT2 - Categories');
    if(this.get('categoryInputText') === '') {
      this.set('noCategories', false);
      console.log('DEBUG --CT3 - Categories');
      return this.get('defaultCategories');
    }
    else{
      var rx = new RegExp(this.get('categoryInputText').toLowerCase()
      );

      var filteredCategories = this.model.categories.filter(function(category) {
        return category.get('name').match(rx);
      });
      if (filteredCategories.length > 0) {
        this.set('noCategories', false);
        return filteredCategories;
      }
      else {
        this.set('noCategories', true);
        console.log('DEBUG --CTNULL - Categories');
       return null;
      }
    }
  }),
  filteredGenres: Ember.computed('genreInputText', function() {
    console.log('DEBUG --CT2 - Genres');
    if(this.get('genreInputText') === '') {
      this.set('noGenres', false);
      console.log('DEBUG --CT3 - Genres');
      return this.get('defaultGenres');
    }
    else{
      var rx = new RegExp(this.get('genreInputText').toLowerCase()
      );

      var filteredGenres =  this.model.genres.filter(function(genre) {
        return genre.get('name').match(rx);
      });
      if (filteredGenres.length > 0) {
        this.set('noGenres', false);
        return filteredGenres;
      }
      else {
        this.set('noGenres', true);
        console.log('DEBUG --CTNULL - Genres');
       return null;
      }
    }
  }),
  filteredFactTypes: Ember.computed('factTypeInputText', function() {
      console.log('DEBUG --CT2 - Fact Types');
    if(this.get('factTypeInputText') === '') {
      this.set('noFactTypes', false);
      console.log('DEBUG --CT3 - Fact Types');
      return this.get('defaultFactTypes');
    }
    else{
      var rx = new RegExp(this.get('factTypeInputText').toLowerCase()
      );

      var filteredFactTypes =   this.model.factTypes.filter(function(factType) {
        return factType.get('name').match(rx);
      });
      if (filteredFactTypes.length > 0) {
        this.set('noFactTypes', false);
        return filteredFactTypes;
      }
      else {
        this.set('noFactTypes', true);
        console.log('DEBUG --CTNULL - Fact Types');
        return null;
      }
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
    },
    setPDID: function(varDayType, varDayName) { 
      this.set('selectedPDID', varDayType);
      this.set('selectedPDN', varDayName);
    },
    // Panel Controls
    setGPV: function() {
      this.toggleProperty('showGP');
    },
    setCPV: function() {
      this.toggleProperty('showCP');
    },
    setFTPV: function() {
      this.toggleProperty('showFTP');
    },
    setPDPV: function() {
      this.toggleProperty('showPDP');
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
    goHome : function(){
        this.transitionToRoute('index');
    },
    logout() {
      this.get('session').invalidate();
    }
  }
});
