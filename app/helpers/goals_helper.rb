module GoalsHelper

def interlocutorgoals(goals)
	@account == goals.recipient ? goals.sender : goals.recipient
	end 
	
	
end
