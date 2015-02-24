Notifications_Url = {

	
	url: function(url)
	{
	
			return window.location.origin + '/' + url;
		
	},
};

Model_Notifications = {
	accept_friend: function(attr) {
		$.ajax({
			url: Notifications_Url.url('accept_friend'),
			type:'POST',
			dataType: 'json',
			data: {
				username: attr.username,
			},
			success: attr.success,
		});	
	},

	get_messages: function(attr) {
		$.ajax({
			url: Notifications_Url.url('messages_from'),
			type:'POST',
			dataType: 'html',
			data: {
				username: attr.username,
			},
			success: attr.success,
		});	
	},

	respond_message: function(attr) {
		$.ajax({
			url: Notifications_Url.url('respond_message'),
			type:'POST',
			dataType: 'html',
			data: {
				message: attr.message,
				username: attr.username,
			},
			success: attr.success,
		});	
	},

	notification_issue: function(attr) {
		$.ajax({
			url: Notifications_Url.url('notification_issue'),
			type:'POST',
			dataType: 'html',
			data: {
				username: attr.username,
			},
			success: attr.success,
		});	
	},

	notification_preferences: function(attr) {
		$.ajax({
			url: Notifications_Url.url('notification_preferences'),
			type:'POST',
			dataType: 'html',
			data: {
				notification_type: attr.notification_type,
			},
			success: attr.success,
		});	
	},

	notification_unfriend: function(attr) {
		$.ajax({
			url: Notifications_Url.url('delete_friend'),
			type:'POST',
			dataType: 'json',
			data: {
				username: attr.username,
			},
			success: attr.success,
		});	
	},

	notification_hide: function(attr) {
		$.ajax({
			url: Notifications_Url.url('hide_friend'),
			type:'POST',
			dataType: 'json',
			data: {
				username: attr.username,
			},
			success: attr.success,
		});	
	},

	notification_ignore: function(attr) {
		$.ajax({
			url: Notifications_Url.url('ignore_friend'),
			type:'POST',
			dataType: 'json',
			data: {
				username: attr.username,
			},
			success: attr.success,
		});	
	},
};

Notifications = {

	accept_notification: function(e){
		var that = $(this).parent(),
			count = $('.notification_count').html() - 1;
		Model_Notifications.accept_friend({
			username:that.attr('data-index'),
			success: function(data) {
				if(data['success']){
					that.remove();
					$('.notification_count').html(count);
				}
			}
		});
	},

	decline_notification: function(e){
		var that = $(this).parent(),
			count = $('.notification_count').html() - 1;
			that.remove();
			$('.notification_count').html(count);
		Model_Notifications.notification_unfriend({
			username:that.attr('data-index'),
			success: function(data) {
				if(data['success']){
					that.remove();
					$('.notification_count').html(count);
				}
			}
		});
	},

	select_message: function(e){
		Model_Notifications.get_messages({
			username:$(this).attr('data-index'),
			success: function(data) {
				$('#mail_view').html(data);
			}
		});	
	},

	respond_message: function(e){
		if($('#mail_respond_text').val() == "")
		{
			return false;
		}
		Model_Notifications.respond_message({
			username:$(this).attr('data-index'),
			message:$('#mail_respond_text').val(),
			success: function(data) {
				$('#mail_view').html(data);
			}
		});	
	},

	notification_issue: function(e){
		Model_Notifications.notification_issue({
			username:$(this).attr('data-index'),
			success: function(data) {
				$('#notifications_view').html(data);
			}
		});	
	},

	notification_preferences: function(e){
		for (var i = 0; i < $('.notification_menu .selected').length; i++) {
			$($('.notification_menu .selected')[i]).removeClass('selected');
		};
		$(this).addClass('selected');
		var type = $(this).html() == 'Trainer' ?  2 : $(this).html() == 'Gym' ? 3 : 1;
		Model_Notifications.notification_preferences({
			notification_type:type,
			success: function(data) {
				$('.notifications_list').html(data);
			}
		});	
	},

	notification_unfriend: function(e){
		var that = $(this);
		Model_Notifications.notification_unfriend({
			username:$(this).parent().attr('data-index'),
			success: function(data) {
				var count = $('.notification_menu .count').html() - 1,
					friends = count == 1 ? '1 Friend' : count + ' Friends';
				$('.notification_menu .notification_count').html(friends);
				that.parent().remove();
			}
		});
	},

	notification_hide: function(e){
		var that = $(this),
			ignore = $(this).html() == 'Hide Posts' ? 'Show Posts' : 'Hide Posts';
		Model_Notifications.notification_hide({
			username:$(this).parent().attr('data-index'),
			success: function(data) {
				that.html(ignore);
			}
		});
	},

	notification_ignore: function(e){
		var that = $(this),
			ignore = $(this).html() == 'Ignore Posts' ? 'See Posts' : 'Ignore Posts';
		Model_Notifications.notification_ignore({
			username:$(this).parent().attr('data-index'),
			success: function(data) {
				that.html(ignore);
			}
		});
	},

	init: function() {
		$('#notifications li .accept').click(this.accept_notification);
		$('#notifications li .decline').click(this.decline_notification);
		$('#mail_list li').click(this.select_message);
		$('#notification_issue').click(this.notification_issue);
	}
};

$(document).ready(function(){
	Notifications.init();
});
