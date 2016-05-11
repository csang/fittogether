Gym = {
	customize: function(e){
		var color = $('#profile_header .profile_bar').attr('data-color');
		$('#profile_header .profile_bar .profile_data').css('background-color',color);
		$('#profile_header .profile_bar .profile_nav .nav a.selected').css('border-color',color);
	},

	add_or_remove_spot: function(e){
		var self = $(this);
		if(self.hasClass('add')){
			var max = parseInt(self.parent().prev().find('.max').attr('data-count')),
				count = parseInt(self.parent().prev().find('.count').attr('data-count'));
			self.removeClass('add').addClass('remove').text('-').parent().prev().find('.radial-progress').attr('data-progress',Math.round(((count + 1)/max * 100)));
			self.parent().prev().find('.count').attr('data-count',count + 1).text(count+1);
		}else if(self.hasClass('remove')){
			var max = parseInt(self.parent().prev().find('.max').attr('data-count')),
				count = parseInt(self.parent().prev().find('.count').attr('data-count'));
			self.removeClass('remove').addClass('add').text('+').parent().prev().find('.radial-progress').attr('data-progress',Math.round(((count - 1)/max * 100)));
			self.parent().prev().find('.count').attr('data-count',count - 1).text(count-1);
		}
	},

	init: function(){
		Gym.customize();

		


		$(window).bind('hashchange', function() {
			if(window.location.hash == '#classes'){
				$("#feed_container").load("../views/classes.html");
			}else if(window.location.hash == '#trainers'){
				$("#feed_container").load("../views/trainers.html");
			}else if(window.location.hash == '#members'){
				$("#feed_container").load("../views/members.html");
			}
			var color = $('#profile_header .profile_bar').attr('data-color');
			$('#profile_header .profile_bar .profile_nav .nav a:not(.selected)').css('border-color','transparent');
			$('#profile_header .profile_bar .profile_nav .nav a.selected').css('border-color',color);
		});
	}
}

$(document).ready(function(){
	// less.refreshStyles();
	Gym.init();
})