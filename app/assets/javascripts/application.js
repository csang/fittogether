// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
// require turbolinks
//= require ckeditor/init
//= require_tree .

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
                    setTimeout(function() {
                        $('.flash-message').fadeOut().html('');
                    }, 5000);
	}
};

Window = {
	prevent_window_scroll: function(e){
		//$('html, body, #content').css('overflow', 'hidden');
	},

	allow_window_scroll: function(e){
		//$('html, body, #content').css('overflow', 'scroll');
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
		$('#nav_container .search input').attr('placeholder','People, groups, zipcode and city');
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
	
		e.preventDefault();
		if (e.keyCode == 27) {
			$('.search_results_section').hide('slow');
			return false;
		}	
	    var keyword = $(this).val();
	    if (keyword.length < 1) {
			$('.search_results_section').hide('slow');
			return false;
		}	
		if (keyword.length >= 2) {
		$.ajax({
			type: "POST",
			url: '/search_people/'+ keyword, //sumbits it to the given url of the form
			dataType: "HTML",
			beforeSend: function(xhr) {
					xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
					},
		    success: function(data){
			
				$('.search_results_section').html(data);
				
				$('.search_results_section').show('slow');
				
				},
		    error:	function (xhr, ajaxOptions, thrownError) {
				console.log(xhr.status)
				
			}	
		
	    });
		}
		
		
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
			$(this).find('.on').hide().next().show().parent().prev().hide();
		}else{		
			$(this).find('.off').hide().prev().show().parent().prev().show();
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
		$('.chat_bar .power').click(this.toggle_chat);
		$('.chat_bar .contacts').click(this.show_contacts);
		$('#container #right_side .chat .users .user').click(this.open_new_chat);

		$('#left_side').height($(window).height());
		$('#left_side_fixed').height($(window).height());
	}
}

$(document).ready(function(){
	Main_List.init();
	Window.init();
	Nav.init();
	Chat.init();
	/* Validations other rules start*/
     	$.validator.addMethod("alphawithspace", function(value,element) {
		   return this.optional(element) || value == value.match(/^[-a-zA-Z ]+$/); 
		}, "Alphabets only");
		$.validator.addMethod("alpha", function(value,element) {
		   return this.optional(element) || value == value.match(/^[a-zA-Z]+$/); 
		}, "Alphabets only");
		$.validator.addMethod("alphanumericspecial", function(value, element) {
			return this.optional(element) || value == value.match(/^[a-z0-9A-Z#@$%^&*()!]+$/);
		},"Only Characters, Numbers & Special Chars Allowed.");
		$.validator.addMethod("phonenumberhy", function(value, element) {
			return this.optional(element) || value == value.match(/^[0-9-]+$/);
		},"Valid Phone Number");
		$.validator.addMethod("alphanumeric", function(value, element) {
			return this.optional(element) || value == value.match(/^[a-z0-9]+$/i);
		},"Only Characters,Numbers are Allowed");
		
	 /* Validations other rules end*/

	 // For Name only letters
    jQuery(function() {
        jQuery.validator.addMethod("loginRegex", function(value, element) {
            return this.optional(element) || /^[a-zA-Z]+$/i.test(value);
        }, 'Please enter valid name');
    });

    // For Password only letters,numbers   and @,_ as the special characters
    jQuery(function() {
        jQuery.validator.addMethod("passwordRegex", function(value, element) {
            return this.optional(element) || /^[0-9a-zA-Z@_]+$/.test(value);
        }, 'Please enter valid password');
    });

    // For Titles only letters , . and spaces
    jQuery(function() {
        jQuery.validator.addMethod("titleRegex", function(value, element) {
            //return this.optional(element) || /^[a-zA-Z0-9 .,]+$/i.test(value);
            return this.optional(element) || /^[a-zA-Z0-9 .,_-]+$/i.test(value);
        }, 'Please enter valid content');
    });

    // Custom validation for phone
    jQuery(function() {
        jQuery.validator.addMethod("phoneRegex", function(value, element) {
            return this.optional(element) || /^([\+][0-9]{1,3}[\ \.\-])?([\(]{1}[0-9]{2,6}[\)])?([0-9\ \.\-\/]{3,20})((x|ext|extension)[\ ]?[0-9]{1,4})?$/.test(value);
        }, 'Please enter valid phone no');
    });

    // Custom validation for description to validate against html tags
    jQuery(function() {
        jQuery.validator.addMethod("descRegex", function(value, element) {
            return this.optional(element) || /^[a-zA-Z0-9!%@$&*#()-.,:;?\/'_\n ]+$/i.test(value);
        }, 'please enter valid description');
    });

    // Custom validation for email
    jQuery(function() {
        jQuery.validator.addMethod("emailRegex", function(value, element) {
            value = $.trim(value);
            jQuery('#UserEmail').val(value);
            return this.optional(element) || /^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i.test(value);
        }, 'Please enter valid email');
    });	
});
