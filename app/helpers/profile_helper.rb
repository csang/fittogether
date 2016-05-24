module ProfileHelper

	def get_cover(position)
	
	  acc = AccountCover.where(:account_id => @account.id, :position => position ).first
	  acc.present? ? acc.cover(:medium) : ''	
	end

end
