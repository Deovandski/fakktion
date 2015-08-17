import Ember from "ember";

export default Ember.Controller.extend
({
	needs: ['application'],
	genreID: 0,
	factTypeID: 0,
	categoryID: 0, 
	topicID: 0, 
	filteredPosts: Ember.computed('controllers.application.selectedGID', 'controllers.application.selectedCID', 'controllers.application.selectedFTID', 'controllers.application.selectedTID',function()
	{
		//Get variables from ApplicationController
		this.set('genreID', this.get('controllers.application.selectedGID'));
		this.set('factTypeID', this.get('controllers.application.selectedFTID'));
		this.set('categoryID', this.get('controllers.application.selectedCID'));
		this.set('topicID', this.get('controllers.application.selectedTID'));
		
		console.log('Variables Debug: ');
		console.log('genreID DEBUG: ' + this.get('genreID'));
		console.log('factTypeID DEBUG: ' + this.get('factTypeID'));
		console.log('categoryID DEBUG: ' + this.get('categoryID'));
		console.log('topicID DEBUG: ' + this.get('topicID'));
		console.log('Filter called');
		
		// RETURN ALL POSTS
		// 0000
		if(this.get('genreID') === 0 && this.get('factTypeID') === 0 && this.get('categoryID') === 0 && this.get('topicID') === 0)
		{
			return this.model.get('posts');
		}
		
     	// INDIVIDUAL SELECTION
		// 1000
		else if(this.get('genreID') !== 0 && this.get('factTypeID') === 0 && this.get('categoryID') === 0 && this.get('topicID') === 0)
		{
			return this.model.get('posts').filterBy('genre_id', parseInt(this.get('genreID')));
     	}
		// 0100
  		else if(this.get('genreID') === 0 && this.get('factTypeID') !== 0 && this.get('categoryID') === 0 && this.get('topicID') === 0)
	  	{
			return this.model.get('posts').filterBy('fact_type_id', parseInt(this.get('factTypeID')));
	  	}
		// 0010
     	else if(this.get('genreID') === 0 && this.get('factTypeID') === 0 && this.get('categoryID') !== 0 && this.get('topicID') === 0)
     	{
			return this.model.get('posts').filterBy('categorie_id', parseInt(this.get('categoryID')));
     	}
		// 0001
     	else if(this.get('genreID') === 0 && this.get('factTypeID') === 0 && this.get('categoryID') === 0 && this.get('topicID') !== 0)
     	{
			return this.model.get('posts').filterBy('topic_id', parseInt(this.get('topicID')));
     	}
		
     	// TWO AT A TIME SELECTION
		// 1100
     	else if(this.get('genreID') !== 0 && this.get('factTypeID') !== 0 && this.get('categoryID') === 0 && this.get('topicID') === 0)
     	{
			return this.model.get('posts').filterBy('genre_id', parseInt(this.get('genreID'))).filterBy('fact_type_id', parseInt(this.get('factTypeID')));
     	}
		// 0110
     	else if(this.get('genreID') === 0 && this.get('factTypeID') !== 0 && this.get('categoryID') !== 0 && this.get('topicID') === 0)
     	{
			return this.model.get('posts').filterBy('fact_type_id', parseInt(this.get('factTypeID'))).filterBy('categorie_id', parseInt(this.get('categoryID')));
     	}
		// 0011
     	else if(this.get('genreID') === 0 && this.get('factTypeID') === 0 && this.get('categoryID') !== 0 && this.get('topicID') !== 0)
     	{
			return this.model.get('posts').filterBy('categorie_id', parseInt(this.get('categoryID'))).filterBy('topic_id', parseInt(this.get('topicID')));
     	}
		// 1010
     	else if(this.get('genreID') !== 0 && this.get('factTypeID') === 0 && this.get('categoryID') !== 0 && this.get('topicID') === 0)
     	{
			return this.model.get('posts').filterBy('genre_id', parseInt(this.get('genreID'))).filterBy('fact_type_id', parseInt(this.get('factTypeID')));
     	}
		// 0101
     	else if(this.get('genreID') === 0 && this.get('factTypeID') !== 0 && this.get('categoryID') === 0 && this.get('topicID') !== 0)
     	{
			return this.model.get('posts').filterBy('fact_type_id', parseInt(this.get('factTypeID'))).filterBy('topic_id', parseInt(this.get('topicID')));
     	}
		// 1001
     	else if(this.get('genreID') !== 0 && this.get('factTypeID') === 0 && this.get('categoryID') === 0 && this.get('topicID') !== 0)
     	{
			return this.model.get('posts').filterBy('genre_id', parseInt(this.get('genreID'))).filterBy('topic_id', parseInt(this.get('topicID')));
     	}
		
     	// THREE AT A TIME SELECTION

		// 0111
     	else if(this.get('genreID') === 0 && this.get('factTypeID') !== 0 && this.get('categoryID') !== 0 && this.get('topicID') !== 0)
     	{
			return this.model.get('posts').filterBy('fact_type_id', parseInt(this.get('factTypeID'))).filterBy('categorie_id', parseInt(this.get('categoryID'))).filterBy('topic_id', parseInt(this.get('topicID')));
     	}
		// 1011
     	else if(this.get('genreID') !== 0 && this.get('factTypeID') === 0 && this.get('categoryID') !== 0 && this.get('topicID') !== 0)
     	{
			return this.model.get('posts').filterBy('genre_id', parseInt(this.get('genreID'))).filterBy('categorie_id', parseInt(this.get('categoryID'))).filterBy('topic_id', parseInt(this.get('topicID')));
     	}
		// 1101
     	else if(this.get('genreID') !== 0 && this.get('factTypeID') !== 0 && this.get('categoryID') === 0 && this.get('topicID') !== 0)
     	{
			return this.model.get('posts').filterBy('genre_id', parseInt(this.get('genreID'))).filterBy('fact_type_id', parseInt(this.get('factTypeID'))).filterBy('topic_id', parseInt(this.get('topicID')));
     	}	
		// 1110
     	else if(this.get('genreID') !== 0 && this.get('factTypeID') !== 0 && this.get('categoryID') !== 0 && this.get('topicID') === 0)
     	{
			return this.model.get('posts').filterBy('genre_id', parseInt(this.get('genreID'))).filterBy('fact_type_id', parseInt(this.get('factTypeID'))).filterBy('categorie_id', parseInt(this.get('categoryID')));
     	}
		// 1111	
		else
		{
			return this.model.get('posts').filterBy('genre_id', parseInt(this.get('genreID'))).filterBy('fact_type_id', parseInt(this.get('factTypeID'))).filterBy('categorie_id', parseInt(this.get('categoryID'))).filterBy('topic_id', parseInt(this.get('topicID')));
		}
	})
});
