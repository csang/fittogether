module ChallengesHelper

def interlocutor(challenge)
	@account == challenge.recipient ? challenge.sender : challenge.recipient
	end 
	
	
end
