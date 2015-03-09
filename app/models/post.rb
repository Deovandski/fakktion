class Post < ActiveRecord::Base
  validates :fact_link, presence: true
  validates :fiction_link, presence: true
  validates :post_name, presence: true
      
  #scope :genres_filtered, -> (genres_id) { where genres_id: genres_id }
  #scope :fact_types_filtered, -> (fact_types_id) { where fact_types_id: fact_types_id }
  
  #scope :categories_filtered, -> (genres_id,categories_id) { where genres_id: genres_id}   {where categories_id: categories_id}
  
  #scope :fact_dates_filtered, -> (fact_types_id,fact_dates_id) { where fact_types_id: fact_types_id} {where fact_dates_id: fact_dates_id}
  	
    # Search Level 3
  	#@post_l3_topics_filtered = Post.find(genre_params[:genres_id],categorie_param[:categories_id],topic_param[:topics_id])
  	
  	# Hybrid Searchs
  	
    # Level 1
  	#@post_l1_filtered = Post.find(genre_params[:genres_id],fact_type_param[:fact_types_id])
  	
    # Level 2
  	#@post_full_filtered = Post.find(genre_params[:genres_id],fact_type_param[:fact_types_id],fact_date_param[:fact_dates_id])
  	
    # Level 2
    
  has_many :comments
  belongs_to :user
  belongs_to :genre
  belongs_to :topic
  belongs_to :posting_date
  belongs_to :fact_type
end
