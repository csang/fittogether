$(document).ready(function () {
 	jQuery.validator.addMethod("require_from_group", function(value, element, options) {
    var numberRequired = options[0];
    var selector = options[1];
    //Look for our selector within the parent form
    var validOrNot = $(selector, element.form).filter(function() {
         // Each field is kept if it has a value
         return $(this).val();
         // Set to true if there are enough, else to false
      }).length >= numberRequired;
    if(!$(element).data('being_validated')) {
		var fields = $(selector, element.form);
		fields.data('being_validated', true);
		// .valid() means "validate using all applicable rules" (which 
		// includes this one)
		fields.valid();
		fields.data('being_validated', false);
    }
    return validOrNot;
		// {0} below is the 0th item in the options field
    }, jQuery.format("Please fill out at least {0} of these fields.")); 
    $("#loginform").validate({
        rules: {
            'login_username': {
                required: true,
                email: true
            },
            'login_password': {
                required: true

            }
        },
        messages: {
            'login_username': {
                required: 'Please enter email.',
                email: 'Please enter valid email.'
            },
            'login_password': {
                required: 'Please enter password.',
            }
        },
		highlight: function(element) {
            $(element).removeClass("error");
        }
    });

	$("#forgotform").validate({
        rules: {
            'login_username': {
                required: true,
                email: true
            },
            'login_password': {
                required: true

            }
        },
        messages: {
            'login_username': {
                required: 'Please enter email.',
                email: 'Please enter valid email.'
            },
            'login_password': {
                required: 'Please enter new password.',
            }
        },
		highlight: function(element) {
            $(element).removeClass("error");
        }
    });
    
    $("#registerform").validate({
        rules: {
            'register_fname': {
                required: true,
                loginRegex:true,
                minlength:3,
                maxlength:20        
            },
            'register_lname': {
                required: true,
                loginRegex:true,
                minlength:3,
                maxlength:20
            },
            'register_username': {
                required: true,
                alphanumeric:true,
                minlength:3,
                maxlength:25
            },
            'register_email': {
                required: true,
                emailRegex:true,
                email: true
            },
            'register_password': {
                required: true,
                passwordRegex:true,
                minlength:5,
                maxlength:15
            },
           'register_verify_password':{
               required:true, 
               equalTo:'#confirm_password' 
            },
            'register[tos_agreement]':{
               required:true, 
            }
        },
        messages: {
            'register_fname': {
                required: 'Please enter first name'
            },
            'register_lname': {
                required: 'Please enter last name'
            },
            'register_username': {
                required: 'Please enter user name'
            },
            'register_email': {
                required: 'Please enter email',
                email: 'Please enter valid email'
            },
            'register_password': {
                required: 'Please enter password'
            },
           'register_verify_password':{
               required:'Please enter confirm password', 
               equalTo:'Confirm password does not matches' 
            },
            'register[tos_agreement]':{
                required:'Please accept the terms & conditions'
            }
        },
		highlight: function(element) {
            $(element).removeClass("error");
        }
    });
    
    
   /* $("#social_settings_form").validate({
        ignore: [],
        groups: {
                'test': 'account[fb_link] account[tw_link] account[google_link] account[linked_link]' 
        },
        rules: {
            'account_trainers[gym_id]': {
                required: true
            },
            'account_trainers[fitness_discpline]': {
                required: true
            },
            'account_trainers[certs]': {
                required: true,
                descRegex:true          
            },
            'account_trainers[awards]': {
                required: true,
                descRegex:true        
            },
            'account_trainers[personal_training]': {
                required: true
            },
            'account_trainers[location_bootcamp]': {
                required: function(){
                   var value = $("input[name='account_trainers[bootcamp]']:checked", '#social_settings_form').val();
                  return (value == 'yes') ? true : false;
                }
            },
            'account_trainers[age]': {
                digits: true,
                maxlength:3        
            },
            'account[fb_link]': {
                require_from_group: [1,".fillone"],
                url: true     
            },
            'account[tw_link]': {
                require_from_group: [1,".fillone"],
                url: true    
            },
            'account[google_link]': {
                require_from_group: [1,".fillone"],
                url: true     
            },
            'account[linked_link]': {
                require_from_group: [1,".fillone"],
                url: true      
            },
        },
        messages: {
            'account_trainers[gym_id]': {
                required: 'Please select main gym'
            },
            'account_trainers[fitness_discpline]': {
                required: 'Please enter fitness disciplines'
            },
            'account_trainers[certs]': {
                required: 'Please enter certs'
            },
            'account_trainers[awards]': {
                required: 'Please enter Other qualifications or awards',
            },
            'account_trainers[personal_training]': {
                required: 'Please select personal training sessions in people\'s homes'
            },
            'account_trainers[location_bootcamp]': {
                required: 'Please enter bootcamp location'
            },
            'account_trainers[age]': {
                digits: 'Please enter digits only'                        
            },
        },
        highlight: function(element) {
            $(element).removeClass("error");
        },
                
            
    }); */


   jQuery.validator.addMethod('zipcode', function(value, element) {
  return this.optional(element) || !!value.trim().match(/^\d{5}(?:[-\s]\d{4})?$/);
}, 'Invalid zip code, Try usa zipcode');
     
    $("#abt").validate({
        rules: {
            'gender': {
                required: true,
              },
            'zipcode': {
                required: true,
                zipcode: true

            }
        },
        messages: {
            'gender': {
                required: 'Please select gender.',
                
            },
            'zipcode': {
                required: 'Please enter zipcode.',
            }
        },
	    highlight: function(element) {
            $(element).removeClass("error");
        }
    });
    
    // hide show gym dropdown
    $('#nogym').on('click', function(){
        $('#showgym').hide();
    });
	
	// hide show gym dropdown
        $('#yesgym').on('click', function(){
           $('#showgym').show();
	});
	
	$(document).ajaxStart(function() {		
	  
	   $('.full-loader').show();
	  
	});

	$(document).ajaxStop(function() {
		 setTimeout(function() {
			$('.full-loader').hide();
			  }, 1000)
	});
	
	$("#updateprofile").validate({
        rules: {
            'fname': {
                required: true,
                loginRegex:true,
                minlength:3,
                maxlength:20                
            },
            'lname': {
                required: true,
                loginRegex:true,
                minlength:3,
                maxlength:20
            },
            'username': {
                required: true,
                alphanumeric:true,
                minlength:3,
                maxlength:25
            },
             'url':{
                url:true 
             } 
        },
        messages: {
            'fname': {
                required: 'Please enter first name.'
                
            },
            'lname': {
                required: 'Please enter last name.',
            }
            ,
            'username': {
                required: 'Please enter user name.',
            }
        },
	highlight: function(element) {
            $(element).removeClass("error");
        }
    });
    
      $("#updatepassword").validate({
        rules: {
            'new_password': {
                required: true,
                minlength:5,
                maxlength:7
                
            },
            'verify_password': {
                required: true,
                equalTo     : '#new_password'

            }
        },
        messages: {
            'new_password': {
                required: 'Please enter new password.',
               
            },
            'verify_password': {
                required: 'Please verify new password.',
                
            }
        },
	highlight: function(element) {
            $(element).removeClass("error");
        }
    });
    
    $('#groupclasses').on('click', function() {
		
		var ss = $(this).val()
     	if (ss.indexOf("7") != -1) {
			$('.Dance').show();
		} else {
			$('.Dance').hide();
		}	
		});
   $('#tyes').on('click', function(){
	   $('.fee').show();
	});		
	
	$('#tno').on('click', function(){
	   $('.fee').hide();
	});		

    
        $("#update_about_gym").validate({
        rules: {
            'name': {
                required: true,
              },
            'address[]': {
                required: true,
                
            },
            'specialty[]': {
                required: true,
                
            },
            'franchise': {
                required: true,
                
            },
            'groupclasses[]': {
                required: true,
                
            },
            'train_client_at_your_gym': {
                required: true,
                
            },
            'sunday_start' : {
				 required: true
			 },
		     'sunday_end' : {
				 required: true
			 },
		     'monday_start' : {
				 required: true
			 },
		     'monday_end' : {
				 required: true
			 },
		     'tuesday_start' : {
				 required: true
			 },
		     'tuesday_end' : {
				 required: true
			 },
		     'wednesday_start' : {
				 required: true
			 },
		     'wednesday_end' : {
				 required: true
			 },
		     'thrusday_start' : {
				 required: true
			 },
		     'thrusday_end' : {
				 required: true
			 },
		     'firday_start' : {
				 required: true
			 },
		     'friday_end' : {
				 required: true
			 },
		     'saturday_start' : {
				 required: true
			 },
		     'saturday_end' : {
				 required: true
			 },
            'amenity[]': {
                required: true,
                
            }								 		
        },
        messages: {
            'name': {
                required: 'Please enter name.',
                
            },
            'address[]': {
                required: 'Please enter address.',
            },
            'specialty[]': {
                required: 'Please select specialty.',
            },
            'franchise': {
                required: 'Please select franchise.',
            },
            'groupclasses[]': {
                required: 'Please select group.',
            },
            'train_client_at_your_gym': {
                required: 'Please select train.',
                
            },
            'sunday_start' : {
				 required: 'Please select open time.',
			 },
		     'sunday_end' : {
				 required: 'Please select close time.',
			 },
		     'monday_start' : {
				 required: 'Please select open time.',
			 },
		     'monday_end' : {
				 required: 'Please select close time.',
			 },
		     'tuesday_start' : {
				 required: 'Please select open time.',
			 },
		     'tuesday_end' : {
				 required: 'Please select close time.',
			 },
		     'wednesday_start' : {
				 required: 'Please select open time.',
			 },
		     'wednesday_end' : {
				 required: 'Please select close time.',
			 },
		     'thuresday_start' : {
				 required: 'Please select open time.',
			 },
		     'thuresday_end' : {
				 required: 'Please select close time.',
			 },
		     'firday_start' : {
				 required: 'Please select open time.',
			 },
		     'friday_end' : {
				 required: 'Please select close time.',
			 },
		     'saturday_start' : {
				 required: 'Please select open time.',
			 },
		     'saturday_end' : {
				 required: 'Please select close time.',
			 },
		     'amenity[]' : {
				 required: 'Please select amenity.',
			 }		
        },
	    highlight: function(element) {
            $(element).removeClass("error");
        }
    });
   
}); // end of document dot ready

