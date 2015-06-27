import Ember from "ember";

export default Ember.Controller.extend({
  genreSelected: 0,
  categorieSelected: 0,
  factTypeSelected: 0,
  
  actions: 
  {
    selectGenre: function(genre) 
    { 
       this.set('genreSelected', genre.id);
       //console.log('selectGenre.Genre.id: ' + genre.id);
       //console.log('selectGenre.genreSelected: ' + this.get('genreSelected'));
    },
    selectCategorie: function(categorie) 
    { 
      this.set('categorieSelected', categorie.id);
    },
    selectFactType: function(factType) 
    { 
      this.set('factTypeSelected', factType.id);
    }
  }
});
