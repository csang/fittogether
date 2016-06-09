$(document).ready(function() {
	/*
	$('#login_container p span').click(function(event) {
		$('#register_container').show();
		$('#forgot_container').hide();
		$('#login_container').hide();
		
	});
	$('#register_container p span').click(function(event) {
		$('#login_container').show();
		$('#register_container').hide();
		$('#forgot_container').hide();
	});
	$('#register_container #register_view ul li').click(function(event) {
		for (var i = 0; i < $('#register_container #register_view ul .select').length; i++) {
			$($('#register_container #register_view ul .select')[i]).removeClass('select');
		};
		$(this).addClass('select');
		$('#register_container #register_view input[name="register_account_type"]').val($(this).attr('data-index'));
	});
	$('#fp').click(function(event) {
		$('#forgot_container').show();
		$('#login_container').hide();
	});
	$('#forgot_container p ').click(function(event) {
		$('#forgot_container').hide();
		$('#register_container').hide();
		$('#login_container').show();
	});
	*/
	
});

/* ============ Sign up js added ================== */
Signup = {
	select_user_type: function(e){
		var self = $(this);
		if(self.val() != ''){
			$('.authentication form .user .cover').css('opacity','0');
			setTimeout(function() {
				$('.authentication form .user .cover').hide();
			}, 500);
			if(self.val() != '1'){
				$('.authentication form .user .social, .authentication form .user .separator').hide();
			}else{
				$('.authentication form .user .social, .authentication form .user .separator').show();
			}
		}else{
			$('.authentication form .user .cover').show().css('opacity','1');
		}
	},

	log_in_popup: function(e){
		$('#login_popup').show();
		$('#forgot_popup').hide();
		$('#login_popup .close_bg').click(Signup.close_log_in_popup);
	},
	forgot_in_popup: function(e){
		$('#login_popup').hide();
		$('#forgot_popup').show();
		$('#forgot_popup .close_bg').click(Signup.close_forgot_in_popup);
	},

	close_log_in_popup: function(e){
		$('#login_popup').hide();
	},
	close_forgot_in_popup: function(e){
		$('#forgot_popup').hide();
	},

	valid_name: function(name){
		if(name.length > 1){
			return true
		}else{
			return false;
		}
	},

	valid_username: function(username){
		if(username.length > 3){
			$('.authentication form input[name="username"]').css('border','1px solid rgb(47,131,82)');
			return true
		}else{
			$('.authentication form input[name="username"]').css('border','1px solid #c66160');
			return false;
		}
	},

	valid_email: function(email){

		if(email.indexOf('@') >= 0 && email.indexOf('.') >= 0 && email.length > 5){
			var segments = email.split('@'),
			user = segments[0],
			domain = segments[1].split('.');

			if(user.length > 0 && domain[0].length > 0 && domain[1].length > 1){
				$('.authentication form input[name="email"]').css('border','1px solid rgb(47,131,82)');
				return true;
			}else{
				$('.authentication form input[name="email"]').css('border','1px solid #c66160');
				return false;
			}
		}else{
			$('.authentication form input[name="email"]').css('border','1px solid #c66160');
			return false;
		}
	},

	valid_password: function(password,verify_password){
		if(password.length > 7){
			if(password === verify_password){
				return true;
				$('.authentication form input[name="password"]').css('border','1px solid rgb(47,131,82)');
				$('.authentication form input[name="verify_password"]').css('border','1px solid rgb(47,131,82)');
			}else{
				$('.authentication form input[name="password"]').css('border','1px solid #c66160');
				$('.authentication form input[name="verify_password"]').css('border','1px solid #c66160');
				return false;
			}
		}else{
			$('.authentication form input[name="password"]').css('border','1px solid #c66160');
			$('.authentication form input[name="verify_password"]').css('border','1px solid #c66160');
		}
	},

	validate_form: function(e){
		var first_name = $('.authentication form input[name="first_name"]').val(),
			last_name = $('.authentication form input[name="last_name"]').val(),
			username = $('.authentication form input[name="username"]').val(),
			email = $('.authentication form input[name="email"]').val(),
			password = $('.authentication form input[name="password"]').val(),
			verify_password = $('.authentication form input[name="verify_password"]').val(),
			valid = true;

		if(!Signup.valid_name(first_name)){
			valid = false;
			$('.authentication form input[name="first_name"]').css('border','1px solid #c66160');
		}else if(!Signup.valid_name(last_name)){
			valid = false;
			$('.authentication form input[name="last_name"]').css('border','1px solid #c66160');
		}else if(!Signup.valid_username(username)){
			valid = false;
		}else if(!Signup.valid_email(email)){
			valid = false;
		}else if(!Signup.valid_password(password,verify_password)){
			valid = false;
		}else{
			$('.authentication form input[name="first_name"]').css('border','1px solid rgb(47,131,82)');
			$('.authentication form input[name="last_name"]').css('border','1px solid rgb(47,131,82)');
		}

		if(valid === false){
			setTimeout(function() {return false;}, 2000);
		}
	},

	init: function(){
		$('.authentication form select[name="user_type"]').change(Signup.select_user_type);
		$('.authentication .login button').click(Signup.log_in_popup);
		$('#forgot_container p').click(Signup.log_in_popup);
		$('#fp').click(Signup.forgot_in_popup);
		//$('.authentication form .submit button').click(Signup.validate_form);
	}
}

$(document).ready(function(){
	Signup.init();
})
