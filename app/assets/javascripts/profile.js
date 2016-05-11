Profile = {
	on_scroll: function(e){
	var dig = $('#body').offset().top- $(window).scrollTop();
		if(dig < -170){
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
		$(window).scroll(Profile.on_scroll);
		var nav_elements = $('#profile_header .profile_bar .profile_nav .nav a');
		for (var i = nav_elements.length - 1; i >= 0; i--) {
			nav_elements[i]
			if($(nav_elements[i]).attr('href') == window.location.hash){
				$('#profile_header .profile_bar .profile_nav .nav a').removeClass('selected');
				$(nav_elements[i]).addClass('selected');
				var page = $(nav_elements[i]).attr('href').replace('#','');
				$("#feed_container").load("../views/"+page+".html");
			}
		};

	
	}
}

$(document).ready(function(){

	Profile.init();
})
