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
end
