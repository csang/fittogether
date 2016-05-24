Settings_Url = {

	url: function(url)
	{
		
			return window.location.origin + '/settings/' + url;
		
	},
};

Model_Settings = {

	check_user_data: function(attr) {
		$.ajax({
			url: Settings_Url.url('check_user_data'),
			type:'POST',
			dataType: 'json',
			data: {
				username: attr.username,
				type: attr.check_type,
			},
			success: attr.success,
		});	
	},

	check_password: function(attr) {
		$.ajax({
			url: Settings_Url.url('check_password'),
			type:'POST',
			dataType: 'json',
			data: {
				password: attr.password,
			},
			success: attr.success,
		});	
	},

	valid_password: function(attr) {
		$.ajax({
			url: Settings_Url.url('valid_password'),
			type:'POST',
			dataType: 'json',
			data: {
				password: attr.password,
			},
			success: attr.success,
		});	
	},

};

Settings = {
	
	check_radio: function(e){
		var self = $(this);
		self.parent().parent().find('div.radio').removeClass('checked');
		self.parent().addClass('checked');
	},

	check_checkbox: function(e){
		var self = $(this).parent();
		if(self.hasClass('checked')){
			self.removeClass('checked');
		}else{
			self.addClass('checked');
		}
	},

	check_user_data: function(){
		var that = $(this);
		//that.next().html('<img src="' + Settings_Url.url('assets/images/global/round_loader.gif') + '">');
		Model_Settings.check_user_data({
			username:that.val(),
			check_type:that.attr('name'),
			success: function(data) {
				if(data.data =='success'){
				//	that.next().html('&#9813;');
					$('.submit_container #save_changes').attr('disabled','disabled');
				}else{
				//	that.next().html('&#9819;');
					$('.submit_container #save_changes').removeAttr('disabled');
				} 
			}
		});
	},

	check_password: function(e){
		var that = $(this);
		that.next().html('<img src="' + Settings_Url.url('assets/img/global/round_loader.gif') + '">');
		Model_Settings.check_password({
			password:that.val(),
			success: function(data) {
				if(data['success']){
					that.next().html('&#9813;');
					start_password = true;
				}else{
					that.next().html('&#9819;');
					start_password = false;
				} 
			}
		});
	},

	valid_password: function(e){
		var that = $(this);
		that.next().html('<img src="' + Settings_Url.url('assets/img/global/round_loader.gif') + '">');
		Model_Settings.valid_password({
			password:that.val(),
			success: function(data) {
				if(data['success']){
					valid_password = true;
					that.next().html('&#9813;');
				}else{
					valid_password = false;
					that.next().html('&#9819;');
				} 
			}
		});
	},

	confirm_password: function(e){
		var same_password = false;
		$(this).next().html('<img src="' + Settings_Url.url('assets/img/global/round_loader.gif') + '">');
		if($('.notifications_view input[name="new_password"]').val() == $(this).val()){
			$(this).next().html('&#9813;');
			same_password = true;
		}else{
			$(this).next().html('&#9819;');
			same_password = false;
		}
		if(same_password && start_password && valid_password){
			$('.notifications_view .profile_info #save_password').removeAttr('disabled');
		}else{
			$('.notifications_view #save_password').attr('disabled','disabled');
		}
		console.log($(this).val())
	},

	update_info: function(e){
		if($(this).val() == first_name || $(this).val() == last_name){
			$('.notifications_view #save_changes').attr('disabled','disabled');
		}else{
			$('.notifications_view .profile_info #save_changes').removeAttr('disabled');
		}
	},

	update_phone: function(e){
		if(e.keyCode == 46 || e.keyCode == 8 || e.keyCode == 9 || e.keyCode == 27 || e.keyCode == 13 || (e.keyCode == 65 && e.ctrlKey === true) || (e.keyCode >= 35 && e.keyCode <= 39)){
			return true ;
		}else {
			if (e.shiftKey || (e.keyCode < 48 || e.keyCode > 57) && (e.keyCode < 96 || e.keyCode > 105 )){
				return false;
			}
		}
	},

	check_phone: function(e){
		var first = $($('#basic input[name="mobile[]"]')[0]),
			second = $($('#basic input[name="mobile[]"]')[1]),
			third = $($('#basic input[name="mobile[]"]')[2]),
			one = first.val().length,
			two = second.val().length,
			three = third.val().length;

		if(one + two + three == 10){
			$('#basic #save_changes').removeAttr('disabled');
		}else{
			$('#basic #save_changes').attr('disabled','disabled');
		}

		if(one == 3 && 
			e.keyCode != 8 && 
			e.keyCode != 9 && 
			e.keyCode != 37 && 
			e.keyCode != 39 &&
			first.is(':focus')){
			second.focus();
		}else if(one == 3 && 
			two == 3 && 
			e.keyCode != 8 && 
			e.keyCode != 9 && 
			e.keyCode != 37 && 
			e.keyCode != 39 &&
			second.is(':focus')){
			third.focus();
		}else if(one == 3 && 
			two == 3 && 
			three == 4 && 
			e.keyCode != 8 && 
			e.keyCode != 9 && 
			e.keyCode != 37 && 
			e.keyCode != 39 &&
			third.is(':focus')){
			$('#basic #save_changes').focus();
		}
	},

	change_info: function(e){
		$('#basic #change_password').show();
		$('#basic #password_info').hide();
	},

	change_password: function(e){

		$('#password_info').show();
		$('#basic #change_password').hide();
		$('#basic #save_changes').attr('disabled','disabled');
	    return false;
	},

	cancel_password: function(e){
		$('#basic #password_info').hide();
		$('#basic #change_password').show();
	},

	validate_privacy:function(inputs){
		// if(inputs != $('input:radio')){
			$('.privacy_settings button').removeAttr('disabled');
		// }else{
		// 	$('.privacy_settings button').attr('disabled','disabled');
		// }
	},

	add_goal:function(e){
		$(this).parent().find('select:first-child').clone().prependTo($('.goals.row .input'));
	},

	add_why:function(e){
		$(this).parent().find('select:first-child').clone().prependTo($('.why.row .input'));
	},
                
        add_certificates:function(e){
		$(this).parent().find('textarea:first-child').clone().prependTo($('.certs .input'));
	},        
        add_tips:function(e){
		$(this).parent().find('textarea:first-child').clone().prependTo($('.tips .input'));
	},
	 add_address:function(e){
		$(this).parent().find('textarea:first-child').clone().prependTo($('.Address .input'));
	},
   trainer_info: function(e){
		$('.notifications_view .trainer_details_info').show();
		$('.notifications_view .trainer_info').hide();
		$('.notifications_view #save_changes').attr('disabled','disabled');
	},

	cancel_trainer_info: function(e){
		$('.notifications_view .trainer_details_info').hide();
		$('.notifications_view .trainer_info').show();
                $('.notifications_view #save_changes').removeAttr('disabled');
	}, 
	add_class: function(e){
		alert('asdf');
		$('.header .settings_nav nav a').removeClass('selected');
		$(this).addClass('selected');
	},       
                
	init: function() {
		$('.notification_menu #settings li').click(this.settings_views);
		$('.add_goal').click(this.add_goal);
		$('.add_why').click(this.add_why);
                $('.add_certs').click(this.add_certificates);
                $('.add_tips').click(this.add_tips);
                $('.trainer_info').click(this.trainer_info);
                $('.cancel_trainer_info').click(this.cancel_trainer_info);
                 $('.add_address').click(this.add_address);
                 $('.header .settings_nav nav a').click(this.add_class);
	}
};

$(document).ready(function(){
	Settings.init();
	$(window).on("load resize",function(e){
		var win_hight = $(this).height();
		var tis_height = win_hight - 100;
		$('#side_nav').css("height", tis_height);
	});
	
});
