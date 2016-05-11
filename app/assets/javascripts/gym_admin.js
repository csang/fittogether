Var = {
	date: new Date(),
	week: ['Sun','Mon','Tue','Wed','Thu','Fri','Sat'],

}

Gym_admin = {
	view_roster: function(e){
		var self = $(this);
		if(self.prev().height() == 0){
			self.prev().animate({'height':self.prev()[0].scrollHeight+'px'},500);
			self.find('p').text('Collapse Class Roster');
		}else{
			self.prev().animate({'height':'0'},500);
			self.find('p').text('View Class Roster');
		}
	},

	select_hour: function(e){
		var self = $(this);
		if(self.hasClass('selected')){
			return false;
		}else{
			self.parent().find('.option.selected').removeClass('selected');
			self.addClass('selected');
		}
	},

	select_trainer: function(e){
		var self = $(this);
		if(self.hasClass('selected')){
			return false;
		}else{
			self.parent().find('.option.selected').removeClass('selected');
			self.addClass('selected');
		}
	},

	get_this_week: function(e){
		var date = new Date(),
		weekday = date.getDay(),
		day = 1000 * 60 * 60 * 24,
		week = day * 6,
		days = weekday * 1000 * 60 * 60 * 24,
		first_day_in_ms = date.getTime() - days,
		first_day = new Date(first_day_in_ms),
		last_day = new Date(first_day_in_ms + week);

		var months = ['January','February','March','April','May','June','July','August','September','October','November','December'],
		first_day_text = months[first_day.getMonth()] + ' ' + first_day.getDate(),
		last_day_text = months[last_day.getMonth()] + ' ' + last_day.getDate();

		$('#appointments #appointments_container .data_container .header .selector .start').attr('data-date',first_day).text(first_day_text);
		$('#appointments #appointments_container .data_container .header .selector .end').attr('data-date',last_day).text(last_day_text);
	},

	previous_week: function(e){
		var self = $(this),
		date = new Date(),
		today = date.getTime(),
		day = 1000 * 60 * 60 * 24,
		week = day * 6,
		start = new Date(self.next().find('.start').attr('data-date')),
		end = new Date(self.next().find('.end').attr('data-date')),
		start_of_previous_week = start.getTime() - week - day,
		end_of_previous_week = end.getTime() - week - day,
		first_day = new Date(start_of_previous_week),
		last_day = new Date(end_of_previous_week);

		var months = ['January','February','March','April','May','June','July','August','September','October','November','December'],
		first_day_text = months[first_day.getMonth()] + ' ' + first_day.getDate(),
		last_day_text = months[last_day.getMonth()] + ' ' + last_day.getDate();

		if(today < end_of_previous_week){
			if(today > start_of_previous_week && today < end_of_previous_week){
				$('#appointments #appointments_container .data_container .header .selector .highlight').text('This Week');
			}else{
				$('#appointments #appointments_container .data_container .header .selector .highlight').text('');
			}

			$('#appointments #appointments_container .data_container .header .selector .start').attr('data-date',first_day).text(first_day_text);
			$('#appointments #appointments_container .data_container .header .selector .end').attr('data-date',last_day).text(last_day_text);
		   trainers = $('.selected').children().children('div .timeslots').attr('id');
    	   weekly_app(trainers,first_day,last_day)
		}


		// Populate appointments
	},

	next_week: function(e){
		var self = $(this),
		date = new Date(),
		today = date.getTime(),
		day = 1000 * 60 * 60 * 24,
		week = day * 6,
		start = new Date(self.prev().find('.start').attr('data-date')),
		end = new Date(self.prev().find('.end').attr('data-date')),
		start_of_next_week = start.getTime() + week + day,
		end_of_next_week = end.getTime() + week + day,
		first_day = new Date(start_of_next_week),
		last_day = new Date(end_of_next_week);

		var months = ['January','February','March','April','May','June','July','August','September','October','November','December'],
		first_day_text = months[first_day.getMonth()] + ' ' + first_day.getDate(),
		last_day_text = months[last_day.getMonth()] + ' ' + last_day.getDate();
		
		if(today > start_of_next_week && today < end_of_next_week){
			$('#appointments #appointments_container .data_container .header .selector .highlight').text('This Week');
		}else{
			$('#appointments #appointments_container .data_container .header .selector .highlight').text('');
		}

		$('#appointments #appointments_container .data_container .header .selector .start').attr('data-date',first_day).text(first_day_text);
		$('#appointments #appointments_container .data_container .header .selector .end').attr('data-date',last_day).text(last_day_text);
		 trainers = $('.selected').children().children('div .timeslots').attr('id');
    	  weekly_app(trainers,first_day,last_day)
		// Populate appointments
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

		var nav_elements = $('header .gym_nav nav a');
		for (var i = nav_elements.length - 1; i >= 0; i--) {
			nav_elements[i]
			if($(nav_elements[i]).attr('href') == window.location.hash){
				$('header .gym_nav nav a').removeClass('selected');
				$(nav_elements[i]).addClass('selected');
				var page = $(nav_elements[i]).attr('href').replace('#','');
				$("#main_container").load("../gym/"+page+".html");
			}
		};

		$(window).bind('hashchange', function() {
			if(window.location.hash == '#dashboard'){
				$("#main_container").load("../gym/dashboard.html");
			}else if(window.location.hash == '#profile'){
				$("#main_container").load("../gym/profile.html");
			}else if(window.location.hash == '#classes'){
				$("#main_container").load("../gym/classes.html");
			}else if(window.location.hash == '#appointments'){
				$("#main_container").load("../gym/appointments.html");
			}else if(window.location.hash == '#trainers'){
				$("#main_container").load("../gym/trainers.html");
			}else if(window.location.hash == '#members'){
				$("#main_container").load("../gym/members.html");
			}

			for (var i = nav_elements.length - 1; i >= 0; i--) {
				if($(nav_elements[i]).attr('href') == window.location.hash){
					$('header .gym_nav nav a').removeClass('selected');
					$(nav_elements[i]).addClass('selected');
				}
			};
		});

		if(window.location.hash == '#appointments'){
			// Gym_admin.get_this_week();
		}

	}
}

$(document).ready(function(){
	// less.refreshStyles();
	Gym_admin.init();
})
