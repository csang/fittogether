Support_Url = {

	url: function(url)
	{
		if(window.location.hostname == '127.0.0.1')
		{
			return 'http://127.0.0.1/fittogether/public/' + url;
		}
		else
		{
			return window.location.origin + '/' + url;
		}
	},

	page: function(e)
	{
		return window.location.href;
	}

};

Model_Support = {

	ticket_response: function(attr){
		$.ajax({
			url: Support_Url.url('send_message'),
			type:'POST',
			dataType: 'html',
			data: {
				support_issue: attr.support_issue,
				ticket_number: attr.ticket_number,
				status: attr.ticket_status,
			},
			success: attr.success,
		});	
	},

};

Support = {

	help: function(){
		$('#support_container').hide();
		$('#new_ticket_container').show();
		$(this).hide();
		$('.back').show();
	},

	back_from_help: function(){
		$('#support_container').show();
		$('#new_ticket_container').hide();
		$(this).hide();
		$('.help_me').show();
	},

	validate_issue: function(){
		if($('input[name="support_subject"]').val() != "" && 
			$('textarea[name="support_issue"]').val() != "" && 
			$('select[name="support_problem"]').val() != 0 && 
			$('select[name="support_emotion"]').val() != 0){
			$('.write_ticket_view button').removeAttr('disabled');
		}else{
			$('.write_ticket_view button').attr('disabled','disabled');
		}
	},

	validate_response: function(){
		if($('.respond_ticket_view textarea').val() != ""){
			$('.respond_ticket_view button').removeAttr('disabled');
		}else{
			$('.respond_ticket_view button').attr('disabled','disabled');
		}
	},

	send_message: function(){
		
		Model_Support.ticket_response({
			support_issue: $('.support_issue').val(),
			ticket_number: $('.ticket_number').val(),
			ticket_status: $('.ticket_status').val(),
			success: function(data) {
				$('.notifications_view').html(data);
			}
		});
	},

	init: function(e){

	}

};

$(document).ready(function(){
	Support.init();
});
