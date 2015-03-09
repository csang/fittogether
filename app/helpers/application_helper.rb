module ApplicationHelper

  def company_title(company_title)
		content_for :company_title, company_title.to_s
  end
  def title(page_title)
		content_for :title, page_title.to_s
  end
  def meta_keywords(meta_keywords)
    content_for :meta_keywords, meta_keywords.to_s
  end
  def meta_description(meta_description)
    content_for :meta_description, meta_description.to_s
  end


def error_messages(curr_resource)
		return "" if curr_resource.errors.empty?
		messages = curr_resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
		sentence = I18n.t("errors.messages.not_saved",
      count: curr_resource.errors.count,
      resource: curr_resource.class.model_name.human.downcase)

		html = <<-HTML
		<div id="error_explanation" class="preferences_errorExplanation">
		  <h4>#{sentence}</h4>
		  <ul>#{messages}</ul>
		</div>
		HTML
		html.html_safe
	end

  # Sorting Helper Function
	def sortable(column, title = nil)
	  title ||= column.titleize
	  css_class = column == sort_column ? "current #{sort_direction}" : nil
	  direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
	  link_to title, params.merge({:search => params[:search], :sort => column, :direction => direction}), {:class => css_class}
	end
	
  # Active Menu
  def active_if(page_name)
    if params[:controller] == page_name
      "list-group-item active"
    else
      "list-group-item"
    end
  end
  
   def flash_class(level)
    case level
    when :notice then "alert alert-success"
    when :success then "alert alert-success"
    when :error then "alert alert-danger"
    when :alert then "alert alert-danger"
    end
  end
  
   def get_activity_name(id)
     activityName = Activity.where(:id => id).first
     return (activityName.present?) ?  activityName['name'] : false ; 
   end
   
   def get_gym_name(id)
     gymName = AccountGym.where(:id => id).first
     return (gymName.present?) ?  gymName['name'] : 'N/A' ; 
   end
   
   def get_city_name(id)
     cityName = City.where(:id => id).first
     return (cityName.present?) ?  cityName['name'] : false ; 
   end
   
   def get_state_name(code)
     stateName = State.where(:state_code => code).first
     return (stateName.present?) ?  stateName['name'] : false ; 
   end
   
   def get_goal_name(id)
     goalName = Goal.where(:id => id).first
     return (goalName.present?) ?  goalName['name'] : false ; 
   end
   def get_relationship_name(id)
     relName = Relationship.where(:id => id).first
     return (relName.present?) ?  relName['name'] : false ; 
   end
   
   def get_field_value(model,column, value)
     result = model.constantize.where(:id => value).first
     return (result.present?) ?  result[column] : false ;
   end
   
    def get_specialty_name(id)
     speName = Specialty.where(:id => id).first
     return (speName.present?) ?  speName['name'] : false ; 
   end
   
    def get_amenity_name(id)
     ameName = Amenity.where(:id => id).first
     return (ameName.present?) ?  ameName['name'] : false ; 
   end
   
    def get_user_name(id)
     gymName = AccountGym.where(:id => id).first
     if gymName.present?
       uName = Account.select('user_name').where(:id => gymName['account_id']).first
      end 
      return (uName.present?) ?  uName['user_name'] : false ; 
   end
   
   def get_user_detail(id)
   
     userdetails =  Account.where(:id => id).first
      
      return userdetails;
	
   end 
   
   def check_if_friend(postuserid, loginuserid)
    
    @friend = Friendship.where(:account_id => postuserid , :friend_id =>loginuserid, :approved => true).first 
	if !@friend.present?
		@friend = Friendship.where(:account_id => loginuserid  , :friend_id =>loginuserid, :approved => true).first 
	end	
     return (@friend.present?) ?  true : false ; 
   
   end
   
     
end
