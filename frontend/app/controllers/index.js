import Ember from "ember";
import moment from 'moment';
const { service } = Ember.inject;

/* The direct ids used on Index filter matching methodology
* has been choosen due to how complex it can become when attempting
* to use DS.BelongsTo(). See Ember Data #1865 for more info...
*/
export default Ember.Controller.extend ({
  application: Ember.inject.controller('application'),
  session:        service('session'),
  sessionAccount: service('session-account'),
  isBanned: Ember.computed('sessionAccount.user.reputation', function() {
    if(this.get('sessionAccount.user.reputation') < -250){
      return true;
    }
    else{
      return false;
    }
  }),
  filteredPosts: Ember.computed('application.selectedGenre',
  'application.selectedCategory', 'application.selectedFactType',
  'application.selectedTopic', 'application.selectedPDID',
  function() {
    // Get variables from ApplicationController
    var tempPosts = this.model;
    var genreID = parseInt(this.get('application.selectedGenre.id'));
    var factTypeID = parseInt(this.get('application.selectedFactType.id'));
    var categoryID = parseInt(this.get('application.selectedCategory.id'));
    var topicID = parseInt(this.get('application.selectedTopic.id'));
    var postDateID = this.get('application.selectedPDID');
    
    /*
    // DEBUG
    console.log('Variables Debug: ');
    console.log('genreID DEBUG: ' + genreID);
    console.log('factTypeID DEBUG: ' + factTypeID);
    console.log('categoryID DEBUG: ' + categoryID);
    console.log('topicID DEBUG: ' + topicID);
    console.log('postDateID DEBUG: ' + postDateID);
    console.log('Filter called');
    */
    
    if(genreID > 0) {
      tempPosts = tempPosts.filterBy('genre_id', genreID);
    }
    
    if(factTypeID > 0) {
      tempPosts = tempPosts.filterBy('fact_type_id', factTypeID);
    }
    
    if(categoryID > 0) {
      tempPosts = tempPosts.filterBy('category_id', categoryID);
    }
    
    if(topicID > 0) {
      tempPosts = tempPosts.filterBy('topic_id', topicID);
    }
    
    if(postDateID !== 0) {
      var today = moment().subtract(1,'d').toDate();
      var yesterday = moment().subtract(2,'d').toDate();
      var pastWeek = moment().subtract(7,'d').toDate();
      var pastTwoWeeks = moment().subtract(14,'d').toDate();
      var pastMonth = moment().subtract(1,'months').toDate();
      var pastThreeMonths = moment().subtract(3,'months').toDate();
      var pastSixMonths = moment().subtract(6,'months').toDate();
      var pastYear = moment().subtract(1,'y').toDate();
      var pastTwoYears = moment().subtract(2,'y').toDate();
      var pastThreeYears = moment().subtract(3,'y').toDate();
      
      switch(postDateID){
        // Today
        case 1:
          tempPosts = tempPosts.filter(function(post) {
            return ((post.get('created_at') >= today));
          });
          break;
        // Yesterday
        case 2:
          tempPosts = tempPosts.filter(function(post) {
            return ((post.get('created_at') >= yesterday && post.get('created_at') <= today));
          });
          break;
        // Past Week
        case 3:
          tempPosts = tempPosts.filter(function(post) {
            return (post.get('created_at') >= pastWeek);
          });
          break;
        // Past 2 Weeks
        case 4:
          tempPosts = tempPosts.filter(function(post) {
            return (post.get('created_at') >= pastTwoWeeks);
          });
          break;
        // Past Month
        case 5:
          tempPosts = tempPosts.filter(function(post) {
            return (post.get('created_at') >= pastMonth);
          });
          break;
        // Past 3 Months
        case 6:
          tempPosts = tempPosts.filter(function(post) {
            return (post.get('created_at') >= pastThreeMonths);
          });
          break;
        // Past 6 Months
        case 7:
          tempPosts = tempPosts.filter(function(post) {
            return (post.get('created_at') >= pastSixMonths);
          });
          break;
        // Past Year
        case 8:
          tempPosts = tempPosts.filter(function(post) {
            return (post.get('created_at') >= pastYear);
          });
          break;
        // Past 2 Years
        case 9:
          tempPosts = tempPosts.filter(function(post) {
            return (post.get('created_at') >= pastTwoYears);
          });
          break;
        // Past 3 Years
        case 10:
          tempPosts = tempPosts.filter(function(post) {
            return (post.get('created_at') >= pastThreeYears);
          });
          break;
      }
    }
    return tempPosts;
  })
});
