var feed = $('.feed').clone();

Feed_Url = {

	
	url: function(url)
	{
		
			return window.location.origin + '/' + url;
		
	},
};

Model_Feed = {
		add_more_posts: function(attr) {
		$.ajax({
			url: Feed_Url.url('more_posts'),
			type:'GET',
			dataType: 'html',
			success: attr.success,
		});	
	},
};

Feed = {

	add_more_posts: function(e){
		$('#feed_loader').html('<img src="assets/global/loader.gif">');
		Model_Feed.add_more_posts({
			success: function(data) {
				$('#feed_loader').empty();
				$('#feed_view').append(data);
			}
		});
	},

	comment_view: function(e){
		if($(this).html() == 'Post'){
			$('#post').show();
			$('#photo_video').hide();
			$('.comment_view input[name="type"]').val(0);
		}else{
			$('#post').hide();
			$('#photo_video').show();
			$('.comment_view input[name="type"]').val(1);
		}
	},

	add_comment: function(e){
		$(this).parent().parent().next().toggle();
	},

	change_category: function(e){

		var uppercased_category = $(this).text(),
			category = $(this).text().toLowerCase(),
			all_posts = $(feed).find('.post').clone(),
			category_feed = $(feed).find('.'+category).clone();

		$('#left_side #account_info #feed_side_nav li').removeClass('selected');
		$('#left_side #account_info #feed_side_nav li:contains("'+ uppercased_category +'")').addClass('selected');

		$('.feed .post').remove()

		if(category == 'all posts'){
			$('.feed').append(all_posts);
		}else{
			$('.feed').append(category_feed);
		}

		Feed.organize_feed();
	},

	organize_feed: function(e){

		if($(window).innerWidth() > 980){
			setTimeout(function(){
				$('#content').css('width', '730px');
				$('.feed .post:nth-child(odd), .feed .post:nth-child(even)').removeClass('left').css('margin', '10px');
				$('.vertical_line').show();
				$('.feed .post:nth-child(odd), .feed .day').css('float', 'left');
				$('.feed .post:nth-child(even)').css('float', 'right');

				for (var i = 0; i < $('.feed .post').length; i++) {

					if($('.feed .post')[i].offsetLeft != $('.feed .post')[0].offsetLeft &&
						$('.feed .post')[i].offsetLeft != $('.feed .post')[1].offsetLeft &&
						$($('.feed .post')[i]).css('float') == 'left'){
						
						$('.feed .post')[i].style.float = 'right';

					}else if($('.feed .post')[i].offsetLeft != $('.feed .post')[0].offsetLeft &&
						$('.feed .post')[i].offsetLeft != $('.feed .post')[1].offsetLeft &&
						$($('.feed .post')[i]).css('float') == 'right'){
						
						$('.feed .post')[i].style.float = 'left';
					};

					if($($('.feed .post')[i]).css('float') == 'left'){

						$($('.feed .post')[i]).removeClass('right');
						$($('.feed .post')[i]).addClass('left');
						
				
					}else if($($('.feed .post')[i]).css('float') == 'right'){
						
						$($('.feed .post')[i]).removeClass('left');
						$($('.feed .post')[i]).addClass('right');
				
					};

					if(i>0){
						if($('.feed .post')[i].offsetTop >= $('.feed .post')[i-1].offsetTop &&
							$('.feed .post')[i].offsetTop <= $('.feed .post')[i-1].offsetTop + 85){

							$('.feed .post')[i].style.marginTop = '75px';

						}
					}
				};
				if($('.vertical_line')[0] != undefined) {
					$('.vertical_line').height($('.post').last()[0].offsetTop - $('.vertical_line')[0].offsetTop);
					$('.feed').css('opacity', '1');
			    }

			}, 200);
		}else{
			$('.vertical_line').hide();
			$('.feed .post:nth-child(odd), .feed .post:nth-child(even), .feed .day').css('float', 'none');
			$('.feed .post:nth-child(odd), .feed .post:nth-child(even)').removeClass('left right').addClass('right').css('margin', '20px auto');
			$('.feed').css('opacity', '1');
		}

	},

	check_categories_height: function(e){
		$('#left_side #account_info #feed_side_nav').height(window.innerHeight - 526);
	},

	ad_switch: function(e){
		if($('#left_side .advertisement_switch .switch .on').css('opacity') == '0'){

			$('#left_side .advertisement_switch .switch .on').animate({
				'opacity': '1',
			}, 250);

			$('#left_side .advertisement_switch .switch .off').animate({
				'opacity': '0',
			}, 250)

			$('#left_side .advertisement_switch .switch .knob').animate({
				'margin': '-25px 0 0 55px', 
				'background-color': '#00ff4e',
			}, 250);

			$('.left_ad, .right_ad').show();

			$('.left_ad, .right_ad').animate({
				'opacity': '1',
			}, 250);

		}else{

			$('#left_side .advertisement_switch .switch .on').animate({
				'opacity': '0',
			}, 250);

			$('#left_side .advertisement_switch .switch .off').animate({
				'opacity': '1',
			}, 250)
			
			$('#left_side .advertisement_switch .switch .knob').animate({
				'margin': '-25px 0 0 5px', 
				'background-color': '#ff3f32',
			}, 250);

			$('.left_ad, .right_ad').animate({
				'opacity': '0',
			}, 250, function(){
				$('.left_ad, .right_ad').hide();
			});
		}
	},

	add_comment: function(e){
		if($(this).parent().parent().find('.comment_box').is(':hidden')){
			$(this).parent().parent().find('.comment_box').show();
		}else{
			$(this).parent().parent().find('.comment_box').hide();
		}
		
		Feed.organize_feed();
		return false;
	},

	init: function(feed) {
		// $(window).scroll(function(event) {
		// 	var wintop = $(window).scrollTop(), 
		// 	docheight = $(document).height(), 
		// 	winheight = $(window).height(),
		// 	scrolltrigger = 0.95;
		// 	if((wintop/(docheight-winheight)) > scrolltrigger){
		// 		Feed.add_more_posts();
		// 	}
		// });
		$(window).resize(function(event){
			Feed.organize_feed();
			Feed.check_categories_height();
		});
		this.organize_feed();
		this.check_categories_height();
		$('.view_comments').click(this.add_comment);
		$('.comment_view h3').click(this.comment_view);
		$('#left_side #account_info #feed_side_nav li').click(this.change_category);
		$('#left_side .advertisement_switch .switch').click(this.ad_switch);
		$('.feed .post .bottom .add_comment').click(this.add_comment)
	}
};

$(document).ready(function(){
	Feed.init();
});
