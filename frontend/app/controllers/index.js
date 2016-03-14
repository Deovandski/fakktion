import Ember from "ember";
import moment from 'moment';

/* The direct ids used on Index filter matching methodology
* has been choosen due to how complex it can become when attempting
* to use DS.BelongsTo(). See Ember Data #1865 for more info...
*/
export default Ember.Controller.extend ({
	application: Ember.inject.controller('application'),
	filteredPosts: Ember.computed('application.selectedGID',
	'application.selectedCID', 'application.selectedFTID',
	'application.selectedTID', 'application.selectedPDID',
	function() {
		// Get variables from ApplicationController
		var tempPost = this.model;
		var genreID = parseInt(this.get('application.selectedGID'));
		var factTypeID = parseInt(this.get('application.selectedFTID'));
		var categoryID = parseInt(this.get('application.selectedCID'));
		var topicID = parseInt(this.get('application.selectedTID'));
		/*
			postDateID === 1 | Today
			postDateID === 2 | Yesterday
			postDateID === 3 | Past Week
			postDateID === 4 | Past Month
			postDateID === 5 | Past 6 Months
			postDateID === 6 | Past Year
		*/
		var postDateID = parseInt(this.get('application.selectedPDID'));
		
		if(genreID !== 0) {
			tempPost = tempPost.filterBy('genre_id', genreID);
		}
		
		if(factTypeID !== 0) {
			tempPost = tempPost.filterBy('fact_type_id', factTypeID);
		}
		
		if(categoryID !== 0) {
			tempPost = tempPost.filterBy('category_id', categoryID)
		}
		
		if(topicID !== 0) {
			tempPost = tempPost.filterBy('topic_id', topicID);
		}
		
		if(postDateID !== 0) {
			var today = moment().subtract(1,'d').toDate();
			var yesterday = moment().subtract(2,'d').toDate();
			var pastWeek = moment().subtract(7,'d').toDate();
			var pastMonth = moment().subtract(1,'months').toDate();
			var pastSixMonths = moment().subtract(6,'months').toDate();
			var pastYear = moment().subtract(1,'y').toDate();
			if(postDateID === 1) { // Today 
				tempPost = tempPost.filter(function(post) {
					return ((post.get('created_at') >= today));
				});
			}
			else if(postDateID === 2) { // Yesterday
				tempPost = tempPost.filter(function(post) {
					return ((post.get('created_at') >= yesterday && post.get('created_at') <= today));
				});
			}
			else if(postDateID === 3) { // Past Week
				tempPost = tempPost.filter(function(post) {
					return (post.get('created_at') >= pastWeek);
				});
			}
			else if(postDateID === 4) { // Past Month
				tempPost = tempPost.filter(function(post) {
					return (post.get('created_at') >= pastMonth);
				});
			}
			else if(postDateID === 5) { // Past 6 months
				tempPost = tempPost.filter(function(post) {
					return (post.get('created_at') >= pastSixMonths);
				});
			}
			else if(postDateID === 5) { // Past Year
				tempPost = tempPost.filter(function(post) {
					return (post.get('created_at') >= pastYear);
				});
			}
			else {
				
			}
		}
		return tempPost;
	})
});
