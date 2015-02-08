module ApplicationHelper
  include LocalTimeHelper

  def welcome
    @facttype = FactType.new
    @factdate = FactDate.new
    @topic = Topic.new

    @facttypes = FactType.order(fact_name: :asc)
    @factdates = FactDate.order(created_at: :asc)
    @categorys = Category.order(category_name: :asc)
    @genres = Genre.order(genre_name: :asc)
  end
  
  def body_class
    body_class = @body_class || "default"
    body_class += " " + controller.controller_name.dasherize
    body_class += " " + controller.action_name.dasherize
    body_class
  end
  
  def current_user
    if session[:current_user_id]
      @current_user ||= User.where(id:session[:current_user_id]).first 
    else
      nil
    end
  end
  
  def page_title
    page = @title
    if page
      "#{page} | #{site_title}"
    else
      site_title
    end
  end

  def site_title
    "Fakktion"
  end
end
