Group = {
	on_scroll: function(e){
		if($('#body').offset().top < -170){
			$('#profile_header').css({'top':'-170px','position':'fixed'});
			$('#side_info').css({'top':'302px','position':'fixed'});
			$('#feed_container').css({'margin-top':'472px'});
			$('#feed_container > .header').css({'top':'302px','position':'fixed'});
		}else{
			$('#profile_header').css({'top':'inherit','position':'relative'});
			$('#side_info').css({'top':'inherit','position':'absolute'});
			$('#feed_container').css({'margin-top':'0'});
			$('#feed_container > .header').css({'top':'inherit','position':'absolute'});
		}
	},

	init: function(){
		$('body').scroll(Group.on_scroll);

		var nav_elements = $('#profile_header .profile_bar .profile_nav .nav a');
		if(window.location.hash != ''){
			for (var i = nav_elements.length - 1; i >= 0; i--) {
				// nav_elements[i]
				if($(nav_elements[i]).attr('href') == window.location.hash){
					$('#profile_header .profile_bar .profile_nav .nav a').removeClass('selected');
					$(nav_elements[i]).addClass('selected');
					var page = $(nav_elements[i]).attr('href').replace('#','');
					$("#feed_container").load("../group/"+page+".html");
				}
			};
		}else{
			$("#feed_container").load("../group/fit_feed.html");
		}

		$(window).bind('hashchange', function() {
			if(window.location.hash == '#fit_feed'){
				$("#feed_container").load("../group/fit_feed.html");
			}else if(window.location.hash == '#about'){
				$("#feed_container").load("../group/about.html");
			}else if(window.location.hash == '#photos'){
				$("#feed_container").load("../group/photos.html");
			}else if(window.location.hash == '#videos'){
				$("#feed_container").load("../group/videos.html");
			}else if(window.location.hash == '#members'){
				$("#feed_container").load("../group/members.html");
			}else if(window.location.hash == '#events'){
				$("#feed_container").load("../group/events.html");
			}

			for (var i = nav_elements.length - 1; i >= 0; i--) {
				if($(nav_elements[i]).attr('href') == window.location.hash){
					$('#profile_header .profile_bar .profile_nav .nav a').removeClass('selected');
					$(nav_elements[i]).addClass('selected');
				}
			};
		});		
	}
}

$(document).ready(function(){
	Group.init();
})
