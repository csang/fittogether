module FeedHelper
  
  def tag_links(tag)
    link_to tag.strip, tag_path(tag.tr('#', '')) 
  end

  def is_number?(obj)
    obj.to_s == obj.to_i.to_s
  end
    
  def user_links(id)
    
    newid =  Base64.decode64(id)
    if is_number?(newid)
      user =  Account.find(newid) 
      if user.present?
        last =  user.last_name.present? ? user.last_name.to_s : ''  
        name = user.first_name + ' ' + last
        link_to name , profile_path(user.user_name) 
      end
    else 
      id
    end
  
  end
  
  def full_name(id)
    newid =  Base64.decode64(id)
    if is_number?(newid)
      user =  Account.find(newid) 
      if user.present?
        last =  user.last_name.present? ? user.last_name.to_s : ''  
        fullname = user.first_name + ' ' + last
        return fullname
      end 
    end
    
  end

 
end
