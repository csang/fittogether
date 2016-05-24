module FitspotsHelper
  
  def email_settings(userid, slug)
    
     pre = AccountEmailSetting.where(:account_id=>userid)
    if !pre.present?
     return 123 
    else
		ip = AccountEmailSetting.where(:account_id=>userid).select(slug).first
		if ip.present? 
		  return ip[slug]
		  else 
		  return false
		  end	
	end	  
    
  end
  
  
  def get_fit_cover(position, id=nil)	
	  acc = FitspotCover.where(:fitspot_id => id, :position => position ).first
	  acc.present? ? acc.cover(:medium) : ''	
	end
	
  def fitspot_count(id)
  
     return FitspotCheckin.where("fitspot_id = ? AND  Date(created_at) = ?", id, Date.today).count
    
  end 	
end
