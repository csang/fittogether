module ChallengesHelper

def interlocutor(challenge)
	@account == challenge.recipient ? challenge.sender : challenge.recipient
	end 
	
	
def get_fitbit_data (id,field)

	abc = Fitbit.where('account_id =?', id ).first
	if abc.present?
		if field == "steps"
			return number_to_human( abc.steps , :format => '%n%u', :units => { :thousand => 'K' })
		elsif field == "distance"
			return  number_with_delimiter(abc.distance)  
		else
			return  number_with_delimiter(abc.calories) 
		end
	else
		return 'n/a'
	end	
end	
	
	
def get_challenge_head(id) 
 chal =  Challenge.find_by_id(id)
 if chal.present? 
 qty = chal.qty == 0 ? "1 month" : " #{chal.qty} week"
 img = useravatar(chal.sender) 
 img2 = useravatar(chal.recipient) 
html = <<-HTML
			 <div class="user">
				<div class="avatar"><a href="profile.html#challenges"><div class="img"></div></a></div>
				<div class="data">
					<a href="profile.html#challenges"><h3 class="name">#{chal.category.name}  Challenge</h3></a>
					<p class="challenge">#{chal.category.name} in 	#{qty} </p>
				</div>
			</div>
			<div class="rivals">
				<div class="user">
				#{link_to(image_tag(img), "/#{chal.sender.user_name}")}
				</div>
				<div><p>VS</p></div>
				<div class="opponent">
				#{link_to(image_tag(img2), "/#{chal.recipient.user_name}")}</div>
			</div>
                            
		HTML
		html.html_safe
end


end	


def get_challenge_body(id)

 chal =  Challenge.find_by_id(id)
 if chal.present? 
 score1 = score2 =  ""
 if chal.category.name == "Most Steps"
	cat = "steps"
 elsif chal.category.name == "Most Miles"
	cat = "distance"
 else
	cat = "calories"	
 end
score1 = get_fitbit_data(chal.sender.id,cat)
score2 = get_fitbit_data(chal.recipient.id,cat)
html = <<-HTML
		     <div class="left">
		<div class="container">
			<div class="background">
				 #{image_tag(chal.sender.avatar(:medium))}
				<div class="cover"></div>
			</div>
			<div class="data">
				<div class="score">
				   <h1>#{score1}</h1>
                        <h3>#{cat}</h3>
				</div>
				<div class="user">
					<h2>#{chal.sender.first_name}<br>#{chal.sender.last_name}</h2>
				</div>
			</div>
		</div>
	</div><div class="right">
		<div class="container">
			<div class="background">
				  #{image_tag(chal.recipient.avatar(:medium))}
				<div class="cover"></div>
			</div>
			<div class="data">
				<div class="score">
					 <h1>#{score2}</h1>
                        <h3>#{cat}</h3>
				</div>
				<div class="user">
				 <h2> #{chal.recipient.first_name} <br> #{chal.recipient.last_name}</h2>
				</div>
			</div>
		</div>
	</div><div class="vs"></div>
		HTML
		html.html_safe

	end
end
	
	
end
