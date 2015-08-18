import Ember from "ember";

export default Ember.Controller.extend
({
	needs: ['application'],
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
	filteredPosts: Ember.computed('controllers.application.selectedGID',
								  'controllers.application.selectedCID',
								  'controllers.application.selectedFTID',
								  'controllers.application.selectedTID',
								  'controllers.application.selectedPDID', function()
	{
		//Get variables from ApplicationController
		this.set('genreID', this.get('controllers.application.selectedGID'));
		this.set('factTypeID', this.get('controllers.application.selectedFTID'));
		this.set('categoryID', this.get('controllers.application.selectedCID'));
		this.set('topicID', this.get('controllers.application.selectedTID'));
		this.set('postDateID', this.get('controllers.application.selectedPDID'));
		
		console.log('Variables Debug: ');
		console.log('genreID DEBUG: ' + this.get('genreID'));
		console.log('factTypeID DEBUG: ' + this.get('factTypeID'));
		console.log('categoryID DEBUG: ' + this.get('categoryID'));
		console.log('topicID DEBUG: ' + this.get('topicID'));
		console.log('postDateID DEBUG: ' + this.get('postDateID'));
		console.log('Filter called');
		
		// RETURN ALL POSTS
		// 00000
		if(this.get('genreID') === 0 && this.get('factTypeID') === 0 && this.get('categoryID') === 0 && this.get('topicID') === 0  && this.get('postDateID') === 0)
		{
			return this.model.get('posts');
		}
		
     	// INDIVIDUAL SELECTION
		// 10000
		else if(this.get('genreID') !== 0 && this.get('factTypeID') === 0 && this.get('categoryID') === 0 && this.get('topicID') === 0  && this.get('postDateID') === 0)
		{
			return this.model.get('posts').filterBy('genre_id', parseInt(this.get('genreID')));
     	}
		// 01000
  		else if(this.get('genreID') === 0 && this.get('factTypeID') !== 0 && this.get('categoryID') === 0 && this.get('topicID') === 0  && this.get('postDateID') === 0)
	  	{
			return this.model.get('posts').filterBy('fact_type_id', parseInt(this.get('factTypeID')));
	  	}
		// 00100
     	else if(this.get('genreID') === 0 && this.get('factTypeID') === 0 && this.get('categoryID') !== 0 && this.get('topicID') === 0  && this.get('postDateID') === 0)
     	{
			return this.model.get('posts').filterBy('categorie_id', parseInt(this.get('categoryID')));
     	}
		// 00010
     	else if(this.get('genreID') === 0 && this.get('factTypeID') === 0 && this.get('categoryID') === 0 && this.get('topicID') !== 0  && this.get('postDateID') === 0)
     	{
			return this.model.get('posts').filterBy('topic_id', parseInt(this.get('topicID')));
     	}
		// 00001
     	else if(this.get('genreID') === 0 && this.get('factTypeID') === 0 && this.get('categoryID') === 0 && this.get('topicID') === 0  && this.get('postDateID') !== 0)
     	{
			return this.model.get('posts').filterBy('topic_id', parseInt(this.get('topicID')));  ///////////////////////////////////////////
     	}
		
     	// TWO AT A TIME SELECTION
		// 11000
     	else if(this.get('genreID') !== 0 && this.get('factTypeID') !== 0 && this.get('categoryID') === 0 && this.get('topicID') === 0  && this.get('postDateID') === 0)
     	{
			return this.model.get('posts').filterBy('genre_id', parseInt(this.get('genreID'))).filterBy('fact_type_id', parseInt(this.get('factTypeID')));
     	}
		// 01100
     	else if(this.get('genreID') === 0 && this.get('factTypeID') !== 0 && this.get('categoryID') !== 0 && this.get('topicID') === 0  && this.get('postDateID') === 0)
     	{
			return this.model.get('posts').filterBy('fact_type_id', parseInt(this.get('factTypeID'))).filterBy('categorie_id', parseInt(this.get('categoryID')));
     	}
		// 00110
     	else if(this.get('genreID') === 0 && this.get('factTypeID') === 0 && this.get('categoryID') !== 0 && this.get('topicID') !== 0  && this.get('postDateID') === 0)
     	{
			return this.model.get('posts').filterBy('categorie_id', parseInt(this.get('categoryID'))).filterBy('topic_id', parseInt(this.get('topicID')));
     	}
		// 00011
     	else if(this.get('genreID') === 0 && this.get('factTypeID') === 0 && this.get('categoryID') === 0 && this.get('topicID') !== 0  && this.get('postDateID') !== 0)
     	{
			return this.model.get('posts').filterBy('categorie_id', parseInt(this.get('categoryID'))).filterBy('topic_id', parseInt(this.get('topicID'))); ///////////////////////////////////////////
     	}
		// 10100
     	else if(this.get('genreID') !== 0 && this.get('factTypeID') === 0 && this.get('categoryID') !== 0 && this.get('topicID') === 0  && this.get('postDateID') === 0)
     	{
			return this.model.get('posts').filterBy('genre_id', parseInt(this.get('genreID'))).filterBy('fact_type_id', parseInt(this.get('factTypeID')));
     	}
		// 01010
     	else if(this.get('genreID') === 0 && this.get('factTypeID') !== 0 && this.get('categoryID') === 0 && this.get('topicID') !== 0  && this.get('postDateID') === 0)
     	{
			return this.model.get('posts').filterBy('fact_type_id', parseInt(this.get('factTypeID'))).filterBy('topic_id', parseInt(this.get('topicID')));
     	}
		// 00101
     	else if(this.get('genreID') === 0 && this.get('factTypeID') !== 0 && this.get('categoryID') !== 0 && this.get('topicID') === 0  && this.get('postDateID') !== 0)
     	{
			return this.model.get('posts').filterBy('fact_type_id', parseInt(this.get('factTypeID'))).filterBy('topic_id', parseInt(this.get('topicID'))); /////////////////////////////////////
     	}
		// 10010
     	else if(this.get('genreID') !== 0 && this.get('factTypeID') === 0 && this.get('categoryID') === 0 && this.get('topicID') !== 0  && this.get('postDateID') === 0)
     	{
			return this.model.get('posts').filterBy('genre_id', parseInt(this.get('genreID'))).filterBy('topic_id', parseInt(this.get('topicID')));
     	}
		// 10001
     	else if(this.get('genreID') !== 0 && this.get('factTypeID') === 0 && this.get('categoryID') === 0 && this.get('topicID') === 0  && this.get('postDateID') !== 0)
     	{
			return this.model.get('posts').filterBy('genre_id', parseInt(this.get('genreID'))).filterBy('topic_id', parseInt(this.get('topicID'))); ////////////////////////////////////
     	}
		
     	// THREE AT A TIME SELECTION

		// 01110
     	else if(this.get('genreID') === 0 && this.get('factTypeID') !== 0 && this.get('categoryID') !== 0 && this.get('topicID') !== 0  && this.get('postDateID') === 0)
     	{
			return this.model.get('posts').filterBy('fact_type_id', parseInt(this.get('factTypeID'))).filterBy('categorie_id', parseInt(this.get('categoryID'))).filterBy('topic_id', parseInt(this.get('topicID')));
     	}
		// 10110
     	else if(this.get('genreID') !== 0 && this.get('factTypeID') === 0 && this.get('categoryID') !== 0 && this.get('topicID') !== 0  && this.get('postDateID') === 0)
     	{
			return this.model.get('posts').filterBy('genre_id', parseInt(this.get('genreID'))).filterBy('categorie_id', parseInt(this.get('categoryID'))).filterBy('topic_id', parseInt(this.get('topicID')));
     	}
		// 11010
     	else if(this.get('genreID') !== 0 && this.get('factTypeID') !== 0 && this.get('categoryID') === 0 && this.get('topicID') !== 0  && this.get('postDateID') === 0)
     	{
			return this.model.get('posts').filterBy('genre_id', parseInt(this.get('genreID'))).filterBy('fact_type_id', parseInt(this.get('factTypeID'))).filterBy('topic_id', parseInt(this.get('topicID')));
     	}	
		// 11100
     	else if(this.get('genreID') !== 0 && this.get('factTypeID') !== 0 && this.get('categoryID') !== 0 && this.get('topicID') === 0  && this.get('postDateID') === 0)
     	{
			return this.model.get('posts').filterBy('genre_id', parseInt(this.get('genreID'))).filterBy('fact_type_id', parseInt(this.get('factTypeID'))).filterBy('categorie_id', parseInt(this.get('categoryID')));
     	}
		// 00111
     	else if(this.get('genreID') === 0 && this.get('factTypeID') === 0 && this.get('categoryID') !== 0 && this.get('topicID') !== 0  && this.get('postDateID') !== 0)
     	{
			return this.model.get('posts').filterBy('categorie_id', parseInt(this.get('categoryID'))).filterBy('topic_id', parseInt(this.get('topicID'))); ////////////////////////////////////////
     	}		
		// 11001
		else if(this.get('genreID') !== 0 && this.get('factTypeID') !== 0 && this.get('categoryID') === 0 && this.get('topicID') === 0  && this.get('postDateID') !== 0)
     	{
			return this.model.get('posts').filterBy('genre_id', parseInt(this.get('genreID'))).filterBy('fact_type_id', parseInt(this.get('factTypeID'))); ////////////////////////////////////////
     	}
		// 10011
     	else if(this.get('genreID') !== 0 && this.get('factTypeID') === 0 && this.get('categoryID') === 0 && this.get('topicID') !== 0  && this.get('postDateID') !== 0)
     	{
			return this.model.get('posts').filterBy('genre_id', parseInt(this.get('genreID'))).filterBy('topic_id', parseInt(this.get('topicID'))); ///////////////////////////////////////////////////////
     	}		
		
		// FOUR AT A TIME SELECTION
		
		// 11110
		else if(this.get('genreID') !== 0 && this.get('factTypeID') !== 0 && this.get('categoryID') !== 0 && this.get('topicID') !== 0  && this.get('postDateID') === 0)
     	{
			return this.model.get('posts').filterBy('genre_id', parseInt(this.get('genreID'))).filterBy('fact_type_id', parseInt(this.get('factTypeID'))).filterBy('categorie_id', parseInt(this.get('categoryID'))).filterBy('topic_id', parseInt(this.get('topicID')));
     	}
		// 11101
		else if(this.get('genreID') !== 0 && this.get('factTypeID') !== 0 && this.get('categoryID') !== 0 && this.get('topicID') === 0  && this.get('postDateID') !== 0)
     	{
			return this.model.get('posts').filterBy('genre_id', parseInt(this.get('genreID'))).filterBy('fact_type_id', parseInt(this.get('factTypeID'))).filterBy('categorie_id', parseInt(this.get('categoryID'))); /////////////////////////////////////////////////////////
     	}		
		// 11011
		else if(this.get('genreID') !== 0 && this.get('factTypeID') !== 0 && this.get('categoryID') === 0 && this.get('topicID') !== 0  && this.get('postDateID') === 0)
     	{
			return this.model.get('posts').filterBy('genre_id', parseInt(this.get('genreID'))).filterBy('fact_type_id', parseInt(this.get('factTypeID'))).filterBy('topic_id', parseInt(this.get('topicID'))); /////////////////////////////////////////////////////////
     	}		
		// 10111
		else if(this.get('genreID') !== 0 && this.get('factTypeID') !== 0 && this.get('categoryID') === 0 && this.get('topicID') !== 0  && this.get('postDateID') === 0)
     	{
			return this.model.get('posts').filterBy('genre_id', parseInt(this.get('genreID'))).filterBy('categorie_id', parseInt(this.get('categoryID'))).filterBy('topic_id', parseInt(this.get('topicID'))); /////////////////////////////////////////////////////////
     	}			
		// 01111
		else if(this.get('genreID') === 0 && this.get('factTypeID') !== 0 && this.get('categoryID') === 0 && this.get('topicID') !== 0  && this.get('postDateID') === 0)
     	{
			return this.model.get('posts').filterBy('fact_type_id', parseInt(this.get('factTypeID'))).filterBy('categorie_id', parseInt(this.get('categoryID'))).filterBy('topic_id', parseInt(this.get('topicID'))); /////////////////////////////////////////////////////////
     	}			
		// 11111
		else
		{
			return this.model.get('posts').filterBy('genre_id', parseInt(this.get('genreID'))).filterBy('fact_type_id', parseInt(this.get('factTypeID'))).filterBy('categorie_id', parseInt(this.get('categoryID'))).filterBy('topic_id', parseInt(this.get('topicID')));
		}
	})
});
