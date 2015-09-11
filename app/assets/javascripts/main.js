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
	}
}

$(document).ready(function(){
	Main_List.init();
	Window.init();
	Nav.init();
	Chat.init();
});
