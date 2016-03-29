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
    
    /*
      postDateID === 1 | Today
      postDateID === 2 | Yesterday
      postDateID === 3 | Past Week
      postDateID === 4 | Past Month
      postDateID === 5 | Past 6 Months
      postDateID === 6 | Past Year
    */
    if(postDateID !== 0) {
      var today = moment().subtract(1,'d').toDate();
      var yesterday = moment().subtract(2,'d').toDate();
      var pastWeek = moment().subtract(7,'d').toDate();
      var pastMonth = moment().subtract(1,'months').toDate();
      var pastSixMonths = moment().subtract(6,'months').toDate();
      var pastYear = moment().subtract(1,'y').toDate();
      if(postDateID === 1) { // Today 
        tempPosts = tempPosts.filter(function(post) {
          return ((post.get('created_at') >= today));
        });
      }
      else if(postDateID === 2) { // Yesterday
        tempPosts = tempPosts.filter(function(post) {
          return ((post.get('created_at') >= yesterday && post.get('created_at') <= today));
        });
      }
      else if(postDateID === 3) { // Past Week
        tempPosts = tempPosts.filter(function(post) {
          return (post.get('created_at') >= pastWeek);
        });
      }
      else if(postDateID === 4) { // Past Month
        tempPosts = tempPosts.filter(function(post) {
          return (post.get('created_at') >= pastMonth);
        });
      }
      else if(postDateID === 5) { // Past 6 months
        tempPosts = tempPosts.filter(function(post) {
          return (post.get('created_at') >= pastSixMonths);
        });
      }
      else if(postDateID === 5) { // Past Year
        tempPosts = tempPosts.filter(function(post) {
          return (post.get('created_at') >= pastYear);
        });
      }
    }
    return tempPosts;
  })
});
