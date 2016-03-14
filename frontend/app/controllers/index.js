import Ember from "ember";
import moment from 'moment';

/* The direct ids used on Index filter matching methodology
* has been choosen due to how complex it can become when attempting
* to use DS.BelongsTo(). See Ember Data #1865 for more info...
*/
export default Ember.Controller.extend ({
	application: Ember.inject.controller('application'),
	genreID: 0,
	factTypeID: 0,
	categoryID: 0,
	topicID: 0,
	postDateID: 0,
	/*	
		postDateID === 1 | Today
		postDateID === 2 | Yesterday
		postDateID === 3 | Past Week
		postDateID === 4 | Past Month
		postDateID === 5 | Past 6 Months
		postDateID === 6 | Past Year
	*/
	filteredPosts: Ember.computed('application.selectedGID',
								  'application.selectedCID',
								  'application.selectedFTID',
								  'application.selectedTID',
								  'application.selectedPDID', function() {
		// Get variables from ApplicationController
		this.set('genreID', this.get('application.selectedGID'));
		this.set('factTypeID', this.get('application.selectedFTID'));
		this.set('categoryID', this.get('application.selectedCID'));
		this.set('topicID', this.get('application.selectedTID'));
		this.set('postDateID', this.get('application.selectedPDID'));
		var posts = this.model;
		
		/*
		console.log('Variables Debug: ');
		console.log('genreID DEBUG: ' + this.get('genreID'));
		console.log('factTypeID DEBUG: ' + this.get('factTypeID'));
		console.log('categoryID DEBUG: ' + this.get('categoryID'));
		console.log('topicID DEBUG: ' + this.get('topicID'));
		console.log('postDateID DEBUG: ' + this.get('postDateID'));
		console.log('Filter called');
		*/
		
		// RETURN ALL POSTS
		// Genre Boolean | FactType Boolean | Category Boolean | Post Date Boolean
		// 00000
		if(this.get('genreID') === 0 && this.get('factTypeID') === 0 && this.get('categoryID') === 0 && this.get('topicID') === 0  && this.get('postDateID') === 0) {
			return posts;
		}
		
     	// INDIVIDUAL SELECTION
		// 10000
		else if(this.get('genreID') !== 0 && this.get('factTypeID') === 0 && this.get('categoryID') === 0 && this.get('topicID') === 0  && this.get('postDateID') === 0) {
			return posts.filterBy('genre_id', parseInt(this.get('genreID')));
     	}
		// 01000
  		else if(this.get('genreID') === 0 && this.get('factTypeID') !== 0 && this.get('categoryID') === 0 && this.get('topicID') === 0  && this.get('postDateID') === 0) {
			return posts.filterBy('fact_type_id', parseInt(this.get('factTypeID')));
	  	}
		// 00100
     	else if(this.get('genreID') === 0 && this.get('factTypeID') === 0 && this.get('categoryID') !== 0 && this.get('topicID') === 0  && this.get('postDateID') === 0) {
			return posts.filterBy('category_id', parseInt(this.get('categoryID')));
     	}
		// 00010
     	else if(this.get('genreID') === 0 && this.get('factTypeID') === 0 && this.get('categoryID') === 0 && this.get('topicID') !== 0  && this.get('postDateID') === 0) {
			return posts.filterBy('topic_id', parseInt(this.get('topicID')));
     	}
		// 00001
     	else if(this.get('genreID') === 0 && this.get('factTypeID') === 0 && this.get('categoryID') === 0 && this.get('topicID') === 0  && this.get('postDateID') !== 0) {
			return this.postingDateFilter(posts);
     	}
		
     	// TWO AT A TIME SELECTION
		// 11000
     	else if(this.get('genreID') !== 0 && this.get('factTypeID') !== 0 && this.get('categoryID') === 0 && this.get('topicID') === 0  && this.get('postDateID') === 0) {
			return posts.filterBy('genre_id', parseInt(this.get('genreID'))).filterBy('fact_type_id', parseInt(this.get('factTypeID')));
     	}
		// 01100
     	else if(this.get('genreID') === 0 && this.get('factTypeID') !== 0 && this.get('categoryID') !== 0 && this.get('topicID') === 0  && this.get('postDateID') === 0) {
			return posts.filterBy('fact_type_id', parseInt(this.get('factTypeID'))).filterBy('category_id', parseInt(this.get('categoryID')));
     	}
		// 00110
     	else if(this.get('genreID') === 0 && this.get('factTypeID') === 0 && this.get('categoryID') !== 0 && this.get('topicID') !== 0  && this.get('postDateID') === 0) {
			return posts.filterBy('category_id', parseInt(this.get('categoryID'))).filterBy('topic_id', parseInt(this.get('topicID')));
     	}
		// 00011
     	else if(this.get('genreID') === 0 && this.get('factTypeID') === 0 && this.get('categoryID') === 0 && this.get('topicID') !== 0  && this.get('postDateID') !== 0) {
			var tempPost = posts.filterBy('topic_id', parseInt(this.get('topicID')));
			return this.postingDateFilter(tempPost);
     	}
		// 10100
     	else if(this.get('genreID') !== 0 && this.get('factTypeID') === 0 && this.get('categoryID') !== 0 && this.get('topicID') === 0  && this.get('postDateID') === 0) {
			return posts.filterBy('genre_id', parseInt(this.get('genreID'))).filterBy('category_id', parseInt(this.get('categoryID')));
     	}
		// 01010
     	else if(this.get('genreID') === 0 && this.get('factTypeID') !== 0 && this.get('categoryID') === 0 && this.get('topicID') !== 0  && this.get('postDateID') === 0) {
			return posts.filterBy('fact_type_id', parseInt(this.get('factTypeID'))).filterBy('topic_id', parseInt(this.get('topicID')));
     	}
		// 00101
     	else if(this.get('genreID') === 0 && this.get('factTypeID') !== 0 && this.get('categoryID') !== 0 && this.get('topicID') === 0  && this.get('postDateID') !== 0) {
			var tempPost = posts.filterBy('category_id', parseInt(this.get('categoryID')));
			return this.postingDateFilter(tempPost);
     	}
		// 10010
     	else if(this.get('genreID') !== 0 && this.get('factTypeID') === 0 && this.get('categoryID') === 0 && this.get('topicID') !== 0  && this.get('postDateID') === 0) {
			return posts.filterBy('genre_id', parseInt(this.get('genreID'))).filterBy('topic_id', parseInt(this.get('topicID')));
     	}
		// 10001
     	else if(this.get('genreID') !== 0 && this.get('factTypeID') === 0 && this.get('categoryID') === 0 && this.get('topicID') === 0  && this.get('postDateID') !== 0) {
			var tempPost = posts.filterBy('genre_id', parseInt(this.get('genreID')));
			return this.postingDateFilter(tempPost);
     	}
		
     	// THREE AT A TIME SELECTION

		// 01110
     	else if(this.get('genreID') === 0 && this.get('factTypeID') !== 0 && this.get('categoryID') !== 0 && this.get('topicID') !== 0  && this.get('postDateID') === 0) {
			return posts.filterBy('fact_type_id', parseInt(this.get('factTypeID'))).filterBy('category_id', parseInt(this.get('categoryID'))).filterBy('topic_id', parseInt(this.get('topicID')));
     	}
		// 10110
     	else if(this.get('genreID') !== 0 && this.get('factTypeID') === 0 && this.get('categoryID') !== 0 && this.get('topicID') !== 0  && this.get('postDateID') === 0) {
			return posts.filterBy('genre_id', parseInt(this.get('genreID'))).filterBy('category_id', parseInt(this.get('categoryID'))).filterBy('topic_id', parseInt(this.get('topicID')));
     	}
		// 11010
     	else if(this.get('genreID') !== 0 && this.get('factTypeID') !== 0 && this.get('categoryID') === 0 && this.get('topicID') !== 0  && this.get('postDateID') === 0) {
			return posts.filterBy('genre_id', parseInt(this.get('genreID'))).filterBy('fact_type_id', parseInt(this.get('factTypeID'))).filterBy('topic_id', parseInt(this.get('topicID')));
     	}	
		// 11100
     	else if(this.get('genreID') !== 0 && this.get('factTypeID') !== 0 && this.get('categoryID') !== 0 && this.get('topicID') === 0  && this.get('postDateID') === 0) {
			return posts.filterBy('genre_id', parseInt(this.get('genreID'))).filterBy('fact_type_id', parseInt(this.get('factTypeID'))).filterBy('category_id', parseInt(this.get('categoryID')));
     	}
		// 00111
     	else if(this.get('genreID') === 0 && this.get('factTypeID') === 0 && this.get('categoryID') !== 0 && this.get('topicID') !== 0  && this.get('postDateID') !== 0) {
			var tempPost = posts.filterBy('category_id', parseInt(this.get('categoryID'))).filterBy('topic_id', parseInt(this.get('topicID')));
			return this.postingDateFilter(tempPost);
     	}		
		// 11001
		else if(this.get('genreID') !== 0 && this.get('factTypeID') !== 0 && this.get('categoryID') === 0 && this.get('topicID') === 0  && this.get('postDateID') !== 0) {
			var tempPost = posts.filterBy('genre_id', parseInt(this.get('genreID'))).filterBy('fact_type_id', parseInt(this.get('factTypeID')));
			return this.postingDateFilter(tempPost);
     	}
		// 10011
     	else if(this.get('genreID') !== 0 && this.get('factTypeID') === 0 && this.get('categoryID') === 0 && this.get('topicID') !== 0  && this.get('postDateID') !== 0) {
			var tempPost = posts.filterBy('genre_id', parseInt(this.get('genreID'))).filterBy('topic_id', parseInt(this.get('topicID')));
			return this.postingDateFilter(tempPost);
     	}		
		
		// FOUR AT A TIME SELECTION
		
		// 11110
		else if(this.get('genreID') !== 0 && this.get('factTypeID') !== 0 && this.get('categoryID') !== 0 && this.get('topicID') !== 0  && this.get('postDateID') === 0) {
			return posts.filterBy('genre_id', parseInt(this.get('genreID'))).filterBy('fact_type_id', parseInt(this.get('factTypeID'))).filterBy('category_id', parseInt(this.get('categoryID'))).filterBy('topic_id', parseInt(this.get('topicID')));
     	}
		// 11101
		else if(this.get('genreID') !== 0 && this.get('factTypeID') !== 0 && this.get('categoryID') !== 0 && this.get('topicID') === 0  && this.get('postDateID') !== 0) {
			var tempPost = posts.filterBy('genre_id', parseInt(this.get('genreID'))).filterBy('fact_type_id', parseInt(this.get('factTypeID'))).filterBy('category_id', parseInt(this.get('categoryID')));
			return this.postingDateFilter(tempPost);
     	}		
		// 11011
		else if(this.get('genreID') !== 0 && this.get('factTypeID') !== 0 && this.get('categoryID') === 0 && this.get('topicID') !== 0  && this.get('postDateID') === 0) {
			var tempPost = posts.filterBy('genre_id', parseInt(this.get('genreID'))).filterBy('fact_type_id', parseInt(this.get('factTypeID'))).filterBy('topic_id', parseInt(this.get('topicID')));
			return this.postingDateFilter(tempPost);
     	}		
		// 10111
		else if(this.get('genreID') !== 0 && this.get('factTypeID') !== 0 && this.get('categoryID') === 0 && this.get('topicID') !== 0  && this.get('postDateID') === 0) {
			var tempPost = posts.filterBy('genre_id', parseInt(this.get('genreID'))).filterBy('category_id', parseInt(this.get('categoryID'))).filterBy('topic_id', parseInt(this.get('topicID')));
			return this.postingDateFilter(tempPost);
     	}			
		// 01111
		else if(this.get('genreID') === 0 && this.get('factTypeID') !== 0 && this.get('categoryID') === 0 && this.get('topicID') !== 0  && this.get('postDateID') === 0) {
			var tempPost = posts.filterBy('fact_type_id', parseInt(this.get('factTypeID'))).filterBy('category_id', parseInt(this.get('categoryID'))).filterBy('topic_id', parseInt(this.get('topicID')));
			return this.postingDateFilter(tempPost);
     	}			
		// 11111
		else {
			var tempPost = posts.filterBy('genre_id', parseInt(this.get('genreID'))).filterBy('fact_type_id', parseInt(this.get('factTypeID'))).filterBy('category_id', parseInt(this.get('categoryID'))).filterBy('topic_id', parseInt(this.get('topicID')));
			return this.postingDateFilter(tempPost);
		}
	}),
	postingDateFilter: function(tempPost) {
		var today = moment().subtract(1,'d').toDate();
		var yesterday = moment().subtract(2,'d').toDate();
		var pastWeek = moment().subtract(7,'d').toDate();
		var pastMonth = moment().subtract(1,'months').toDate();
		var pastSixMonths = moment().subtract(6,'months').toDate();
		var pastYear = moment().subtract(1,'y').toDate();
		
		if(this.get('postDateID') === 1) { // Today 
			return tempPost.filter(function(post) {
				return ((post.get('created_at') >= today));
			});
		}
		else if(this.get('postDateID') === 2) { // Yesterday
			return tempPost.filter(function(post) {
				return ((post.get('created_at') >= yesterday && post.get('created_at') <= today));
			});
		}
		else if(this.get('postDateID') === 3) { // Past Week
			return tempPost.filter(function(post) {
				return (post.get('created_at') >= pastWeek);
			});
		}
		else if(this.get('postDateID') === 4) { // Past Month
			return tempPost.filter(function(post) {
				return (post.get('created_at') >= pastMonth);
			});
		}
		else if(this.get('postDateID') === 5) { // Past 6 months
			return tempPost.filter(function(post) {
				return (post.get('created_at') >= pastSixMonths);
			});
		}
		else if(this.get('postDateID') === 5) { // Past Year
			return tempPost.filter(function(post) {
				return (post.get('created_at') >= pastYear);
			});
		}
		else {
			// Do not filter if postDateID is not recognized
			return tempPost;
		}
	}
});
