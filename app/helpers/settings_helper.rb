module SettingsHelper
  
  
  def getgymlocations(gid)
   
      gyddata = AccountGym.select('address').where(:id =>gid).first 
      return  gyddata.present? ? gyddata : nil
 
  end

end
