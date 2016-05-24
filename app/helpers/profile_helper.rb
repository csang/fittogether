module ProfileHelper

	def get_cover(position)
	
	  user_id = @profileuser.present? ? @profileuser.id : @account.id
	  acc = AccountCover.where(:account_id => user_id, :position => position ).first
	  acc.present? ? acc.cover(:medium) : ''	
	end

end
