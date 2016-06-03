module GroupsHelper

def get_group_cover(position, id=nil)	
	  acc = GroupCover.where(:group_id => id, :position => position ).first
	  acc.present? ? acc : ''	
	end
	
end
