
var chat = true;
Main_List_Url = {

	
	url: function(url)
	{ 	
		
			return window.location.origin + '/' + url;
		
	},
};


Model_Main_List = {

};

Main_List = {

	on_start: function(e){
		$('.chat_bar .chats').width(window.innerWidth - 306);
		$('.chat_bar .chats .list').width(276 * $('.chat_bar .chats .list .chat').length);
		
		if($(window).width() <= 980 && $(window).width() >= 710){
			$('nav .logo').show();
			$('nav .mobile_icon').hide();
			$('#content').css({
				'width': 'calc(100% - 250px)',
			});

			$('#content .comment_view textarea').width(window.innerWidth - 286);
			$('#content .comment_view .post_options .share').width(window.innerWidth - 540);
			$('#content .comment_view .post_options .share h3').hide();
			$('#content .comment_view .post_options .share input').width(window.innerWidth - 586).css('margin', '8px 0 8px 10px');
		}else if($(window).width() < 710){
			$('nav .logo').hide();
			$('nav .mobile_icon').show();
			$('nav .search').width(window.innerWidth - 58 - 58);
			$('#content').css('width', '100%');
			$('#content .comment_view .post_options .share h3').show();

			if($(window).width() <= 550 && $(window).width() > 335){
				$('#content .comment_view textarea').width(window.innerWidth - 37);
				$('#content .comment_view .post_options .share').css('width', '100%');
				$('#content .comment_view .post_options .extra').width(window.innerWidth - 131);
				$('#content .comment_view .post_options .share input').width(window.innerWidth - 155);
			}else if($(window).width() > 550){
				$('#content .comment_view textarea').width(window.innerWidth - 37);
				$('#content .comment_view .post_options .share').width(window.innerWidth - 290);
				$('#content .comment_view .post_options .extra').css('width', 'auto');
				$('#content .comment_view .post_options .share input').width(window.innerWidth - 423).css('margin', '8px 0');
			}else if($(window).width() <= 335){
				$('#content .comment_view .post_options .share').css('width', '100%');
				$('#content .comment_view .post_options .extra').width('');
				$('#content .comment_view .post_options .share input').width('');
				$('nav .search').width(204);
				$('nav .search input').width(140);
			}else{
				$('#content .comment_view textarea').width(window.innerWidth - 36);
			}
		}else{
			$('#content .comment_view textarea').width(694);
			$('#content .comment_view .post_options .share').width(440);
			$('#content .comment_view .post_options .share h3').show();
			$('#content .comment_view .post_options .share input').width(307).css('margin', '8px 0');
		}

		if($(window).width() < 960 && $(window).width() >= 710) {
			$('#left_side').show();
			$('nav .search').width(window.innerWidth - 375);
			$('#content .comment_view_bg').show();
		}else if($(window).width() < 1280 && $(window).width() >= 960){
			$('nav .search').width(585);
			$('#container #right_side, #container #right_side #right_side_fixed').height(0);
		}else if($(window).width() >= 1280){
			$('nav .search').width(730);
			$('#container #right_side, #container #right_side #right_side_fixed').height(window.innerHeight - 109);
			$('#notifications #right_side, #notifications #right_side #right_side_fixed').height(0);
		}
	},

	display_mobile_nav: function(e){
		if($('#left_side').is(':hidden')){
			$('#left_side').show();
			$('#left_side').animate({
				left: '0',
			}, 500, function(){
				$('#content').click(function(){
					$('#left_side').animate({
						left: '-250px',
					}, 500, function(){
						$('#left_side').hide();
					});
				})
			});
		}else{
			$('#left_side').animate({
				left: '-250px',
			}, 500, function(){
				$('#left_side').hide();
			});
		}

		return false;
	},

	display_secondary_nav: function(e){
		if($('.comment_view_bg').is(':hidden')){
			$('.comment_view_bg').show();
		}else{
			$('.comment_view_bg').hide();
		}

		return false;
	},

	redirect_to_settings: function(e){
		window.location = Main_List_Url.url('settings');
	},

	logout: function(e){
		window.location = Main_List_Url.url('logout');
	},

	select: function(e){
		$(this).find('.options').show();
	},

	get_selection: function(e){
		$(this).parent().hide();
	},

	init: function() {
		$('nav .left_nav_icon').click(Main_List.display_mobile_nav);
		$('nav .right_nav_icon').click(Main_List.display_secondary_nav);
		$('#left_side #account_info .settings .url_settings').click(this.redirect_to_settings);
		$('#left_side #account_info .settings .logout').click(this.logout);
		$('.select').click(this.select);
		$('.select .options h4').click(this.get_selection);

		$(window).resize(function(e){			
			Main_List.on_start();
		});

		this.on_start();
	}
};

Window = {
	prevent_window_scroll: function(e){
		$('html, body, #content').css('overflow', 'hidden');
	},

	allow_window_scroll: function(e){
		$('html, body, #content').css('overflow', 'scroll');
	},

	init: function(){
		$('.chat_bar').mouseover(this.prevent_window_scroll);
		$('.chat_bar').mouseout(this.allow_window_scroll);
		$('#right_side .chat .users .list').mouseover(this.prevent_window_scroll);
		$('#right_side .chat .users .list').mouseout(this.allow_window_scroll);
		$('.search_results_section .search_results').mouseover(this.prevent_window_scroll);
		$('.search_results_section .search_results').mouseout(this.allow_window_scroll);
		$('#left_side #account_info').mouseover(this.prevent_window_scroll);
		$('#left_side #account_info').mouseout(this.allow_window_scroll);
	}
}

Nav = {

	change_placeholder: function(e){
		$('#nav_container .search input').attr('placeholder','People, places and activities');
		$('#nav_container .search').css('background-color', '#4ca571');
	},

	reset_placeholder: function(e){
		if(!$('#nav_container .search input').is(':focus')){
			$('#nav_container .search input').attr('placeholder','I\'m lookin for...');
			$('#nav_container .search').css('background-color', '#2f8352');
		};
	},

	focus_search: function(e){
		$('#nav_container .search input').focus();
	},

	show_results: function(e){
		if(e.keyCode == 13){
			if($('#nav_container .search input').val().length < 1){
				$('.search_results_section').animate({
					height: '0px',
				},500);
			}else{
				if(!$('.search_results_section').is(':animated')){
					$('.search_results_section').animate({
						height: window.innerHeight - 145,
					}, 500);

					$('#content').click(function(){
						$('.search_results_section').animate({
							height: '0px',
						},500);	
					})
				};
			};
		};
	},

	display_previews: function(e){

		var selection = this.title;

		if($('.'+selection+'_preview').is(':hidden')){
			$('#nav_container .nav .nav_options img').css('background-color', '');
			$(this).children().css('background-color', '#4ca571');

			$('.black_screen').show().animate({
				backgroundColor: 'rgba(0,0,0,.75)',
			}, 500);
			$('#nav_container .previews').children().hide().css('opacity', '0').parent().find('.'+selection+'_preview').show().animate({
				opacity: 1,
			}, 500);
			$('.black_screen').click(Nav.hide_previews);
		}else{
			Nav.hide_previews();
		}

		

		return false;
	},

	hide_previews: function(){
		$('#nav_container .nav .nav_options').children().css('background-color', '');
		$('#nav_container .previews').children().hide();
		$('.black_screen').hide();
	},

	init: function() {
		$('#nav_container .search').hover(this.change_placeholder);
		$('#nav_container .search').click(this.focus_search);
		$('#nav_container .search input').focus(this.change_placeholder);
		$('#nav_container .search input').focusout(this.reset_placeholder);
		$('#nav_container .search input').keyup(this.show_results);
		$('#nav_container .nav .nav_options').click(this.display_previews);
		$('#container').hover(this.reset_placeholder);
	}
}

Chat = {

	close_chat: function(e){
		$(this).parent().parent().parent().remove();
	},

	minimize_chat: function(e){
		$(this).parent().parent().hide().next().find('span').show();
	},

	show_chat: function(e){
		$(this).find('span').hide().parent().prev().show();
	},

	toggle_chat: function(e){
       
		if(!$('.chat_bar .power .on').is(':hidden')){
                   
			$(this).find('.on').hide();
			$(this).find('.off').show();
		}else{	
               ;
			$(this).find('.off').hide();
			$(this).find('.on').show();
		}
	},

	show_contacts: function(e){
		if($('#container #right_side, #container #right_side #right_side_fixed').height() == 0){
			$('#container #right_side, #container #right_side #right_side_fixed').animate({
				height: window.innerHeight - 109 + 'px',
			}, 500);
		}else{
			$('#container #right_side, #container #right_side #right_side_fixed').animate({
				height: '0px',
			}, 500);
		}
	},

	open_new_chat: function(e){
		console.log('open new chat');
	},

	init: function() {

		$('.close_chat').click(this.close_chat);
		$('.minimize_chat').click(this.minimize_chat);
		$('.chat_bar .chat .user').click(this.show_chat);
		//$('.chat_bar .power').click(this.toggle_chat);
		$('.chat_bar .contacts').click(this.show_contacts);
		$('#container #right_side .chat .users .user').click(this.open_new_chat);
		// new
		
	}
}
Html_template = {
	list_of_friends: '<div id="list_of_friends" class="over_cover">'+
	'<div class="header"><p>Searching for Friends...</p></div>'+
	'<div class="search" id="search_friend"><input type="text" placeholder="Type Friend\'s Name..."></div> '+
	'<div class="list"><div class="searching"><p>Searching...</p></div></div>'+
	'</div>',
	list_of_groups: '<div id="list_of_groups" class="over_cover">'+
	'<div class="header"><button type="button" class="create_group" data-toggle="modal" title="Create Group" data-target="#groupForm" >Create Group</button><p>Searching for Groups...</p></div>'+
	'<div class="search" id="search_hide"><input type="text" placeholder="Type Group\'s Name..."></div>'+
	'<div class="list"><div class="searching"><p>Searching...</p></div></div>'+
	'</div>',
	create_challenge: '<div id="create_challenge" class="over_cover">'+
	'<div class="header"><p>Create Challenge</p></div>'+
	'<div class="description"><p>Challenge your friends to see who can generate the most steps, run/walk the most miles<br>or burn the most calories within the timeframe you define. Challenges start upon acceptance.</p></div>'+
	'<div class="inputs">'+
		'<div class="type"><label>What type of Challenge?</label><select name="challenge_type"><option selected disabled>Select Challenge Type</option><option>Most Steps</option><option>Most Miles</option><option>Most Calories</option></select></div>'+
		'<div class="who"><label>Who do you want to Challenge?</label><input type="text" name="friend" placeholder="Select Friend"></div>'+
		'<div class="time"><label>Challenge Duration:</label><select name="challenge_duration"><option selected disabled>Select Duration</option><option>1 Week</option><option>2 Weeks</option><option>1 Month</option></select></div>'+
	'</div>'+
	'<div class="preview">'+
	'</div>'+
	'<div class="create"><button>Create Challenge</button></div>'+
	'</div>',
	view_picture: '<div id="view_picture" class="over_cover"><div class="header"><p>Picture</p><button type="button" class="close">X</button></div><div class="body"><div class="image"><img src="" ><div class="prev"></div><div class="next"></div></div><div class="comments"></div><textarea placeholder="Add comment..."></textarea></div><div class="footer"><button class="green_btn">Post</button></div></div>',
	view_picture_without_comment: '<div id="view_picture" class="over_cover"><div class="header"><p>Picture</p><button type="button" class="close">X</button></div><div class="body"><div class="image"><img src="" ><div class="prev"></div><div class="next"></div></div><div class="comments"></div></div></div>',
	comment: '<div class="comment">'+
                                        '<div class="avatar">'+
                                            '<a href="profile.html"><img src="../public/img/profile/aaronrodgers_avatar.png" title="Aaron Rodgers" alt="AR"></a>'+
                                        '</div>'+
                                        '<div class="header">'+
                                            '<h5>Aaron Rodgers</h5>'+
                                            '<p class="timestamp">Today at 12:07am</p>'+
                                        '</div>'+
                                        '<div class="text">'+
                                            '<p class="the_comment">We are announing that we will now be open later hours for everyone that wants to work out late. We are now open from 5AM to 12AM Every day! We are very excited to now offer later times for everyone! Trainers will also take appointments for during our new hours! Walk In apointments are only availible from 5AM to 9PM. Thank you hope you enjoy our new hours!</p>'+
                                        '</div>'+
                                    '</div>',
}


Fit = {
	
	  redirect_to_settings: function(e){
		window.location = Main_List_Url.url('settings');
	},
	redirect_home: function(e){
		window.location = Main_List_Url.url('feed');
	},
	write_post: function(e){
		console.log('write post');
		$('body').scrollTop(0);
		$('#feed_container .post_input .container textarea').focus();
	},
	show_challenges: function(e){
		var self = $(this);
		if(self.hasClass('selected')){
			self.removeClass('selected');
			$('#feed .post').show();
		}else{
			self.parent().find('div').removeClass('selected');
			self.addClass('selected')
			$('#feed .post:not(.challenge)').hide();
			$('#feed .post.challenge').show();
		}
	},
	show_friends: function(e){
		Fit.show_dark_cover();
		var left_offset = $('#side_nav .friends_icon').offset().left + 77 + 'px';
		$('body').append(Html_template.list_of_friends).find('#list_of_friends').css({'left':left_offset});

		var count = 180;
		$('#list_of_friends .header p').text(friends.length+' Friends');
		

		$('#list_of_friends .list').empty();
        $.each(friends,function( index , val) {	
		  var html = '<a href="/' + val.user_name +'" ><div class="friend"><div class="avatar"><img src="'+val.avatar+'" alt="'+val.initials+'" title="'+val.full_name+'"></div><p>'+val.full_name+'</p></a></div>';
			$('#list_of_friends .list').append(html);
		
		});
	},
	show_groups: function(e){
		Fit.show_dark_cover();
		var left_offset = $('#side_nav .groups_icon').offset().left + 77 + 'px';
		$('body').append(Html_template.list_of_groups).find('#list_of_groups').css({'left':left_offset});

		var count = groups.length;
		$('#list_of_groups .header p').text(count+' Groups');

		/*var groups = [{'full_name':'Sorba','initials':'S','avatar':'../public/img/group/sorba.png'},
		{'full_name':'Central Florida Divers and Adventurers Clubs','initials':'CF','avatar':'../public/img/group/central_florida_divers_and_adveturers_clubs.png'},
		{'full_name':'Florida Trail Association Highlanders Hiking Group','initials':'FT','avatar':'../public/img/group/florida_trail_association_highlanders_hiking_group.png'}]
		*/
		$('#list_of_groups .list').empty();
		if (count > 0) {
			for (var i = groups.length - 1; i >= 0; i--) {
				var html = '<div class="group"><a href="/groups/'+ btoa(groups[i].id) +'" ><div class="avatar"><img src="'+groups[i].avatar+'" alt="'+groups[i].initials+'" title="'+groups[i].full_name+'"></div><p data="'+groups[i].full_name.toLowerCase() +'">'+groups[i].full_name+'</p></div>';
				$('#list_of_groups .list').append(html);
			};
		} else {
			   var html = '<div class="group"><p> No group found</p></div>';
			   $('#search_hide').hide();
				$('#list_of_groups .list').append(html);
		}		
	},
	show_fitbit: function(e){
		var self = $(this);
		if(self.hasClass('selected')){
			self.removeClass('selected');
			$('#feed .post').show();
		}else{
			self.parent().find('div').removeClass('selected');
			self.addClass('selected')
			$('#feed .post:not(.fitbit)').hide();
			$('#feed .post.fitbit').show();
		}
	},
	show_gym: function(e){
		var self = $(this);
		if(self.hasClass('selected')){
			self.removeClass('selected');
			$('#feed .post').show();
		}else{
			self.parent().find('div').removeClass('selected');
			self.addClass('selected')
			$('#feed .post:not(.gym)').hide();
			$('#feed .post.gym').show();
		}
	},

		show_dark_cover: function(e){
		$('body').append('<div id="dark_cover"></div>').find('> #dark_cover').click(Fit.remove_dark_cover);
	},

	remove_dark_cover: function(e){
		$(this).remove();
		$('.over_cover').remove();
	},
	show_fitspot: function(e){
		var self = $(this);
		if(self.hasClass('selected')){
			self.removeClass('selected');
			$('#feed .post').show();
		}else{
			self.parent().find('div').removeClass('selected');
			self.addClass('selected')
			$('#feed .post:not(.fitspot)').hide();
			$('#feed .post:not(.checkin)').hide();
			$('#feed .post.fitspot').show();
			$('#feed .post.checkin').show();
		}
	},
	toggle_notification_list: function(e){
		var notifications = $('header #top_nav .notifications_icon .notification_list, header #top_nav .notifications_icon #dark_cover');
		if(notifications.css('display') == "none"){
			notifications.css('display','block');
		}else{
			notifications.css('display','none');
		}
	},
		toggle_profile_list: function(e){
		var profile = $('header #top_nav .profile_icon .profile_list, header #top_nav .profile_icon #dark_cover');
		if(profile.css('display') == "none"){
			profile.css('display','block');
		}else{
			profile.css('display','none');
		}
	},
	
	toggle_comments: function(e){
		console.log('boo');
		var self = $(this);
		if(self.parent().prev().css('height') == '0px'){
			var height = self.parent().prev().find('.comment_container').height() + self.parent().prev().find('.add_comment').height() + 37;
			self.parent().prev().css('height',height).find('.add_comment textarea').focus();
			self.parent().prev().find('.comment_container').scrollTop(self.parent().prev().find('.comment_container')[0].scrollHeight);
			self.parent().parent('div .post').addClass('pop_listing');
		}else{
			self.parent().prev().css('height','0px');
			self.parent().parent('div .post').removeClass('pop_listing');
		}
	},
	close_popup: function(e){
		$('body > #dark_cover').remove();
		$('.over_cover').remove();
	},
  
	view_picture_post: function(e){
		var id = $(this).parent().parent().parent('div .post').attr("id");
		var html = $(this).parent().parent().parent('div .post').find(".comment_container").html();
		Fit.show_dark_cover();
		var img = $(this).attr('src');
		$('body').append(Html_template.view_picture).find('#view_picture .header button.close').click(Fit.close_popup);
		$('body #view_picture .body img').attr('src',img);
		$('body #view_picture .body .comments').append(html).scrollTop($('body #view_picture .body .comments').height());
		$('#view_picture .footer button').click(Fit.add_picture_comment);
		$('#view_picture .footer button').attr("data-id",id);
	},
	add_picture_comment: function(e){
		if($('#view_picture textarea').val().length > 0){
			var post_id = $(this).attr("data-id");
			$.ajax({
			  type: "POST",
			  url: '/create_comment/', //sumbits it to the given url of the form
			  data: {text: $('#view_picture textarea').val(), post: post_id},
			  dataType: "HTML",
			  beforeSend: function(xhr) {
				xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
			  }
			  }).success(function(data) {
				$('body #view_picture .body .comments').append(data).scrollTop($('body #view_picture .body .comments').height());
				$('#view_picture textarea').val('');
				$('#'+post_id).find(".comment_container").append(data)
			});
		}
	},
	my_comment: function(message){
		var comment = '<div class="comment">'+
                        '<div class="avatar">'+
                            '<a href="profile.html"><img src="../public/img/profile/mariasharapova_avatar.png" title="Maria Sharapova" alt="MS"></a>'+
                        '</div>'+
                        '<div class="header">'+
                            '<h5>Maria Sharapova</h5>'+
                            '<p class="timestamp">Just now</p>'+
                        '</div>'+
                        '<div class="text">'+
                            '<p class="the_comment">'+message+'</p>'+
                        '</div>'+
                    '</div>';
		return comment;
	},
	update_pill_button: function(e){
		var self = $(this);
		self.siblings("button").removeClass('active');
		self.addClass('active');
		console.log(self.attr('data-filter'))
		if(self.attr('data-filter') == 'attending'){
			$('#side_info .events .attendings').show();
			$('#side_info .events .invited').hide();
			$('#side_info .events .suggested').hide()
		}else if(self.attr('data-filter') == 'invited'){
			$('#side_info .events  .invited').show();
			$('#side_info .events  .attendings').hide();
			$('#side_info .events  .suggested').hide()
		} else {
			$('#side_info .events .invited').hide();
			$('#side_info .events .attendings').hide();
			$('#side_info .events .suggested').show()
		}
	},
	view_picture_post_album: function(e){
		var id = $(this).attr("id");
		$.ajax({
			  type: "GET",
			  url: '/get_comment_on_album_image/' +id, //sumbits it to the given url of the form
			  dataType: "HTML",
			  beforeSend: function(xhr) {
				xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
			  }
			  }).success(function(data) {
				$('body #view_picture .body .comments').append(data).scrollTop($('body #view_picture .body .comments').height());
			});
		Fit.show_dark_cover();
		var img = $(this).attr('src');
		$('body').append(Html_template.view_picture).find('#view_picture .header button.close').click(Fit.close_popup);
		$('body #view_picture .body img').attr('src',img);
		//$('body #view_picture .body .comments').append(html).scrollTop($('body #view_picture .body .comments').height());
		$('#view_picture .footer button').click(Fit.add_picture_comment_album);
		$('#view_picture .footer button').attr("data-id",id);
	},
	add_picture_comment_album: function(e){
		if($('#view_picture textarea').val().length > 0){
			var id = $(this).attr("data-id");
			$.ajax({
			  type: "POST",
			  url: '/create_comment_on_album_image/', //sumbits it to the given url of the form
			  data: {text: $('#view_picture textarea').val(), id: id},
			  dataType: "HTML",
			  beforeSend: function(xhr) {
				xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
			  }
			  }).success(function(data) {
				$('body #view_picture .body .comments').append(data).scrollTop($('body #view_picture .body .comments').height());
				$('#view_picture textarea').val('');				
			});
		}
	},
	
		view_picture_post_collage: function(e){		
		Fit.show_dark_cover();
		var img = $(this).attr('src');
		$('body').append(Html_template.view_picture_without_comment).find('#view_picture .header button.close').click(Fit.close_popup);
		$('body #view_picture .body img').attr('src',img);
		
	},

		init: function(){
	
		$('#side_nav .home_icon').click(Fit.redirect_home);
		$('#side_nav .friends_icon').click(Fit.show_friends);
		$('#side_nav .groups_icon').click(Fit.show_groups);
		$('#side_nav .trophies_icon').click(Fit.show_challenges);
		$('#side_nav .statistics_icon').click(Fit.show_fitbit);
		$('#side_nav .nearby_icon').click(Fit.show_fitspot);
		$('#side_nav .settings_icon').click(Fit.redirect_to_settings);
		$('#side_nav .gym_icon').click(Fit.show_gym);
		$('#feed_container .header .actions button.write_post').click(Fit.write_post);
		$('#feed_container .header .actions button.challenge').click(Fit.challenge);
		//$('#feed_container #feed .post .footer > div.comment').click(Fit.toggle_comments);
		$(document).on('click','#feed_container #feed .post .footer > div.comment',Fit.toggle_comments);
		$('#feed_container .post.photo .content img').click(Fit.view_picture_post);
		
		$('header #top_nav .profile_icon').click(Fit.toggle_profile_list);
		$('header #top_nav .notifications_icon').click(Fit.toggle_notification_list);
		$('.pill_button > button').click(Fit.update_pill_button);
		
	}


}	
		$(document).on('click', '.create_group', function(){
			$(this).parent().parent('div').siblings('#dark_cover').hide();
			$('.over_cover').remove();		
			});
			
	     $(document).on('keyup','.search input', function() {	
			// console.log($('.group p[data]:contains("' + $(this).val().toLowerCase() + '")'))		
			   found_div = $('.group p:contains("' + $(this).val().charAt(0).toUpperCase() + $(this).val().slice(1) + '")');			   
			   $('.group').hide();
			   found_div.parent().parent('div').show();
			    
			 })	
			 
			 $(document).on('keyup','#search_friend input', function() {	
			   found_div = $('.friend p:contains("' + $(this).val().charAt(0).toUpperCase() + $(this).val().slice(1) + '")');			   
			   $('.friend').hide();
			   found_div.parent().parent('div').show();
			    
			 })		

$(document).ready(function(){
	Main_List.init();
	Window.init();
	Nav.init();
	Chat.init();
	Fit.init();

	});
