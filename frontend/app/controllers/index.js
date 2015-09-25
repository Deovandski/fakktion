import Ember from "ember";
import moment from 'moment';

export default Ember.Controller.extend
({
	application: Ember.inject.controller('application'),
	genreID: 0,
	factTypeID: 0,
	categoryID: 0,
	topicID: 0,
	postDateID: 0,
	/*	postDateID === 1 | Today
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
								  'application.selectedPDID', function()
	{
		//Get variables from ApplicationController
		this.set('genreID', this.get('application.selectedGID'));
		this.set('factTypeID', this.get('application.selectedFTID'));
		this.set('categoryID', this.get('application.selectedCID'));
		this.set('topicID', this.get('application.selectedTID'));
		this.set('postDateID', this.get('application.selectedPDID'));
		var posts = this.model.get('posts');
		
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
		// 00000
		if(this.get('genreID') === 0 && this.get('factTypeID') === 0 && this.get('categoryID') === 0 && this.get('topicID') === 0  && this.get('postDateID') === 0)
		{
			return posts;
		}
		
     	// INDIVIDUAL SELECTION
		// 10000
		else if(this.get('genreID') !== 0 && this.get('factTypeID') === 0 && this.get('categoryID') === 0 && this.get('topicID') === 0  && this.get('postDateID') === 0)
		{
			return posts.filterBy('genre.id', parseInt(this.get('genreID')));
     	}
		// 01000
  		else if(this.get('genreID') === 0 && this.get('factTypeID') !== 0 && this.get('categoryID') === 0 && this.get('topicID') === 0  && this.get('postDateID') === 0)
	  	{
			return posts.filterBy('fact_type_id', parseInt(this.get('factTypeID')));
	  	}
		// 00100
     	else if(this.get('genreID') === 0 && this.get('factTypeID') === 0 && this.get('categoryID') !== 0 && this.get('topicID') === 0  && this.get('postDateID') === 0)
     	{
			return posts.filterBy('categorie_id', parseInt(this.get('categoryID')));
     	}
		// 00010
     	else if(this.get('genreID') === 0 && this.get('factTypeID') === 0 && this.get('categoryID') === 0 && this.get('topicID') !== 0  && this.get('postDateID') === 0)
     	{
			return posts.filterBy('topic_id', parseInt(this.get('topicID')));
     	}
		// 00001
     	else if(this.get('genreID') === 0 && this.get('factTypeID') === 0 && this.get('categoryID') === 0 && this.get('topicID') === 0  && this.get('postDateID') !== 0)
     	{
			var today = moment().subtract(1,'d').toDate();
			var yesterday = moment().subtract(2,'d').toDate();
			var pastWeek = moment().subtract(7,'d').toDate();
			var pastMonth = moment().subtract(1,'months').toDate();
			var pastSixMonths = moment().subtract(6,'months').toDate();
			var pastYear = moment().subtract(1,'y').toDate();
			
			if(this.get('postDateID') === 1) { // Today 
				return posts.filter(function(post) {
					console.log(post.get('genre'));
					return ((post.get('created_at') >= today));
				});
			}
			else if(this.get('postDateID') === 2) { // Yesterday
				return posts.filter(function(post) {
					return ((post.get('created_at') >= yesterday && post.get('created_at') <= today));
				});
			}
			else if(this.get('postDateID') === 3) // Past Week
			{
				return posts.filter(function(post) {
					return (post.get('created_at') >= pastWeek);
				});
			}
			else if(this.get('postDateID') === 4) // Past Month
			{
				return posts.filter(function(post) {
					return (post.get('created_at') >= pastMonth);
				});
			}
			else if(this.get('postDateID') === 5) // Past 6 months
			{
				return posts.filter(function(post) {
					return (post.get('created_at') >= pastSixMonths);
				});
			}
			else if(this.get('postDateID') === 5) // Past Year
			{
				return posts.filter(function(post) {
					return (post.get('created_at') >= pastYear);
				});
			}
			else
			{
				// Do not filter if postDateID is not recognized
				return posts;
			}
     	}
		
     	// TWO AT A TIME SELECTION
		// 11000
     	else if(this.get('genreID') !== 0 && this.get('factTypeID') !== 0 && this.get('categoryID') === 0 && this.get('topicID') === 0  && this.get('postDateID') === 0)
     	{
			return posts.filterBy('genre_id', parseInt(this.get('genreID'))).filterBy('fact_type_id', parseInt(this.get('factTypeID')));
     	}
		// 01100
     	else if(this.get('genreID') === 0 && this.get('factTypeID') !== 0 && this.get('categoryID') !== 0 && this.get('topicID') === 0  && this.get('postDateID') === 0)
     	{
			return posts.filterBy('fact_type_id', parseInt(this.get('factTypeID'))).filterBy('categorie_id', parseInt(this.get('categoryID')));
     	}
		// 00110
     	else if(this.get('genreID') === 0 && this.get('factTypeID') === 0 && this.get('categoryID') !== 0 && this.get('topicID') !== 0  && this.get('postDateID') === 0)
     	{
			return posts.filterBy('categorie_id', parseInt(this.get('categoryID'))).filterBy('topic_id', parseInt(this.get('topicID')));
     	}
		// 00011
     	else if(this.get('genreID') === 0 && this.get('factTypeID') === 0 && this.get('categoryID') === 0 && this.get('topicID') !== 0  && this.get('postDateID') !== 0)
     	{
			return posts.filterBy('categorie_id', parseInt(this.get('categoryID'))).filterBy('topic_id', parseInt(this.get('topicID'))); ///////////////////////////////////////////
     	}
		// 10100
     	else if(this.get('genreID') !== 0 && this.get('factTypeID') === 0 && this.get('categoryID') !== 0 && this.get('topicID') === 0  && this.get('postDateID') === 0)
     	{
			return posts.filterBy('genre_id', parseInt(this.get('genreID'))).filterBy('fact_type_id', parseInt(this.get('factTypeID')));
     	}
		// 01010
     	else if(this.get('genreID') === 0 && this.get('factTypeID') !== 0 && this.get('categoryID') === 0 && this.get('topicID') !== 0  && this.get('postDateID') === 0)
     	{
			return posts.filterBy('fact_type_id', parseInt(this.get('factTypeID'))).filterBy('topic_id', parseInt(this.get('topicID')));
     	}
		// 00101
     	else if(this.get('genreID') === 0 && this.get('factTypeID') !== 0 && this.get('categoryID') !== 0 && this.get('topicID') === 0  && this.get('postDateID') !== 0)
     	{
			return posts.filterBy('fact_type_id', parseInt(this.get('factTypeID'))).filterBy('topic_id', parseInt(this.get('topicID'))); /////////////////////////////////////
     	}
		// 10010
     	else if(this.get('genreID') !== 0 && this.get('factTypeID') === 0 && this.get('categoryID') === 0 && this.get('topicID') !== 0  && this.get('postDateID') === 0)
     	{
			return posts.filterBy('genre_id', parseInt(this.get('genreID'))).filterBy('topic_id', parseInt(this.get('topicID')));
     	}
		// 10001
     	else if(this.get('genreID') !== 0 && this.get('factTypeID') === 0 && this.get('categoryID') === 0 && this.get('topicID') === 0  && this.get('postDateID') !== 0)
     	{
			return posts.filterBy('genre_id', parseInt(this.get('genreID'))).filterBy('topic_id', parseInt(this.get('topicID'))); ////////////////////////////////////
     	}
		
     	// THREE AT A TIME SELECTION

		// 01110
     	else if(this.get('genreID') === 0 && this.get('factTypeID') !== 0 && this.get('categoryID') !== 0 && this.get('topicID') !== 0  && this.get('postDateID') === 0)
     	{
			return posts.filterBy('fact_type_id', parseInt(this.get('factTypeID'))).filterBy('categorie_id', parseInt(this.get('categoryID'))).filterBy('topic_id', parseInt(this.get('topicID')));
     	}
		// 10110
     	else if(this.get('genreID') !== 0 && this.get('factTypeID') === 0 && this.get('categoryID') !== 0 && this.get('topicID') !== 0  && this.get('postDateID') === 0)
     	{
			return posts.filterBy('genre_id', parseInt(this.get('genreID'))).filterBy('categorie_id', parseInt(this.get('categoryID'))).filterBy('topic_id', parseInt(this.get('topicID')));
     	}
		// 11010
     	else if(this.get('genreID') !== 0 && this.get('factTypeID') !== 0 && this.get('categoryID') === 0 && this.get('topicID') !== 0  && this.get('postDateID') === 0)
     	{
			return posts.filterBy('genre_id', parseInt(this.get('genreID'))).filterBy('fact_type_id', parseInt(this.get('factTypeID'))).filterBy('topic_id', parseInt(this.get('topicID')));
     	}	
		// 11100
     	else if(this.get('genreID') !== 0 && this.get('factTypeID') !== 0 && this.get('categoryID') !== 0 && this.get('topicID') === 0  && this.get('postDateID') === 0)
     	{
			return posts.filterBy('genre_id', parseInt(this.get('genreID'))).filterBy('fact_type_id', parseInt(this.get('factTypeID'))).filterBy('categorie_id', parseInt(this.get('categoryID')));
     	}
		// 00111
     	else if(this.get('genreID') === 0 && this.get('factTypeID') === 0 && this.get('categoryID') !== 0 && this.get('topicID') !== 0  && this.get('postDateID') !== 0)
     	{
			return posts.filterBy('categorie_id', parseInt(this.get('categoryID'))).filterBy('topic_id', parseInt(this.get('topicID'))); ////////////////////////////////////////
     	}		
		// 11001
		else if(this.get('genreID') !== 0 && this.get('factTypeID') !== 0 && this.get('categoryID') === 0 && this.get('topicID') === 0  && this.get('postDateID') !== 0)
     	{
			return posts.filterBy('genre_id', parseInt(this.get('genreID'))).filterBy('fact_type_id', parseInt(this.get('factTypeID'))); ////////////////////////////////////////
     	}
		// 10011
     	else if(this.get('genreID') !== 0 && this.get('factTypeID') === 0 && this.get('categoryID') === 0 && this.get('topicID') !== 0  && this.get('postDateID') !== 0)
     	{
			return posts.filterBy('genre_id', parseInt(this.get('genreID'))).filterBy('topic_id', parseInt(this.get('topicID'))); ///////////////////////////////////////////////////////
     	}		
		
		// FOUR AT A TIME SELECTION
		
		// 11110
		else if(this.get('genreID') !== 0 && this.get('factTypeID') !== 0 && this.get('categoryID') !== 0 && this.get('topicID') !== 0  && this.get('postDateID') === 0)
     	{
			return posts.filterBy('genre_id', parseInt(this.get('genreID'))).filterBy('fact_type_id', parseInt(this.get('factTypeID'))).filterBy('categorie_id', parseInt(this.get('categoryID'))).filterBy('topic_id', parseInt(this.get('topicID')));
     	}
		// 11101
		else if(this.get('genreID') !== 0 && this.get('factTypeID') !== 0 && this.get('categoryID') !== 0 && this.get('topicID') === 0  && this.get('postDateID') !== 0)
     	{
			return posts.filterBy('genre_id', parseInt(this.get('genreID'))).filterBy('fact_type_id', parseInt(this.get('factTypeID'))).filterBy('categorie_id', parseInt(this.get('categoryID'))); /////////////////////////////////////////////////////////
     	}		
		// 11011
		else if(this.get('genreID') !== 0 && this.get('factTypeID') !== 0 && this.get('categoryID') === 0 && this.get('topicID') !== 0  && this.get('postDateID') === 0)
     	{
			return posts.filterBy('genre_id', parseInt(this.get('genreID'))).filterBy('fact_type_id', parseInt(this.get('factTypeID'))).filterBy('topic_id', parseInt(this.get('topicID'))); /////////////////////////////////////////////////////////
     	}		
		// 10111
		else if(this.get('genreID') !== 0 && this.get('factTypeID') !== 0 && this.get('categoryID') === 0 && this.get('topicID') !== 0  && this.get('postDateID') === 0)
     	{
			return posts.filterBy('genre_id', parseInt(this.get('genreID'))).filterBy('categorie_id', parseInt(this.get('categoryID'))).filterBy('topic_id', parseInt(this.get('topicID'))); /////////////////////////////////////////////////////////
     	}			
		// 01111
		else if(this.get('genreID') === 0 && this.get('factTypeID') !== 0 && this.get('categoryID') === 0 && this.get('topicID') !== 0  && this.get('postDateID') === 0)
     	{
			return posts.filterBy('fact_type_id', parseInt(this.get('factTypeID'))).filterBy('categorie_id', parseInt(this.get('categoryID'))).filterBy('topic_id', parseInt(this.get('topicID'))); /////////////////////////////////////////////////////////
     	}			
		// 11111
		else
		{
			return posts.filterBy('genre_id', parseInt(this.get('genreID'))).filterBy('fact_type_id', parseInt(this.get('factTypeID'))).filterBy('categorie_id', parseInt(this.get('categoryID'))).filterBy('topic_id', parseInt(this.get('topicID')));
		}
	})
});
