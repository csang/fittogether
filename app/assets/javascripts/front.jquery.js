   
$(document).ready(function () {
     $('#timepickernew').timepicker();
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
                userRegex:true,
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
                           setTimeout(function() {
                            $('.flash-message').fadeOut();
			  }, 5000)
                          
                          
	});
        
          $.validator.addMethod("userRegex", function(value, element) {
        return this.optional(element) || /^[a-z0-9\-_@]+$/i.test(value);
    }, "Username must contain only letters, numbers,underscore, @ or dashes.");
	
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
                userRegex:true,
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
    
   $("#challenge_form").validate({
        rules: {
            'challenge[text]': {
                required: true,
              },
              'challenge[qty]':{
             required: true,
             number:true,        
          
              },
              'qty' :{
                required: true,
              }
        },
        messages: {
            'challenge[text]': {
                required: 'Please enter text.',
                
            },
              'challenge[qty]':{
                required: 'Please enter quantity.',
                number: 'Please enter only numeric value.',
              },
              'qty' :{
                required: 'Please select duration.',
              }
        },
	  
    });   
    
      $("#conversation_form").validate({
        rules: {
            'message[body]': {
                required: true,
              }
        },
        messages: {
            'message[body]': {
                required: 'Please enter message.',
                
            }
        },
	  
    });   
    
    
       
   $("#goal_form").validate({
        rules: {
            'account_goal[text]': {
                required: true,
              },
              'account_goal[qty]':{
             required: true,
             number:true,        
          
              },
              'valid_date' :{
                required: true,
              }
        },
        messages: {
            'account_goal[text]': {
                required: 'Please enter text.',
                
            },
              'account_goal[qty]':{
                required: 'Please enter quantity.',
                number: 'Please enter only numeric value.',
              },
              'valid_date' :{
                required: 'Please select date.',
              }
        },
	  
    });   
    
       $("#weekly_goal").validate({
        rules: {
            'value': {
                required: true,
                number:true,  
                maxlength:10
                
            }
        },
        messages: {
            'value': {
                required: 'Please enter value.',
                number: 'Please enter number.',
               
            }
        },
	highlight: function(element) {
            $(element).removeClass("error");
        }
    });
    
      $('#type').on('change', function(){
       $(this).val()=='distance' ? $('.exten').show() :  $('.exten').hide() ;
      });
      
        $("#group_form").validate({
        rules: {
            'group[title]': {
                required: true,
              },
               'group[description]': {
                required: true,
              },
               'group[address]': {
                required: true,
              }
        },
        messages: {
            'group[title]': {
                required: 'Please enter name.',
                
            },'group[description]': {
                required: 'Please enter description.',
                
            },'group[address]': {
                required: 'Please enter address.',
                
            }
        },
	    highlight: function(element) {
            $(element).removeClass("error");
        }
    });
    
           $("#review_form").validate({
        rules: {
            'review[review]': {
                required: true,
              }
        },
        messages: {
            'review[review]': {
                required: 'Please enter review.',
                
            }
        },
	    highlight: function(element) {
            $(element).removeClass("error");
        }
    });
    
        $("#fitspot_form").validate({
        rules: {
            'fitspot[title]': {
                required: true,
              },
              
            'fitspot[location]': {
                required: true,
              },
              
            'fitspot[fitspot_date]': {
                required: true,
              }
        },
        messages: {
            'fitspot[title]': {
                required: 'Please enter name.',
                
            },
             'fitspot[location]': {
                required: 'Please enter location.',
                
            },
             'fitspot[fitspot_date]': {
                required: 'Please select date.',
                
            }
        },
	    highlight: function(element) {
            $(element).removeClass("error");
        }
    });
    
            $("#feedback_form").validate({
        rules: {
            'admin_feedback[feedback]': {
                required: true,
              },
              
        },
        messages: {
            'admin_feedback[feedback]': {
                required: 'Please enter feedback.',
                
            }
        },
	    highlight: function(element) {
            $(element).removeClass("error");
        }
    });
    
       $("#event_form").validate({
        rules: {
            'event[title]': {
                required: true,
              },
              
            'event[description]': {
                required: true,
              },
              
            'event[event_date]': {
                required: true,
              },
              'event[event_start_time]': {
                required: true,
              },
              'event[event_end_time]': {
                required: true,
              }
        },
        messages: {
            'event[title]': {
                required: 'Please enter name.',
                
            },
             'event[description]': {
                required: 'Please enter description.',
                
            },
             'event[event_date]': {
                required: 'Please select date.',
                
            },
             'event[event_start_date]': {
                required: 'Please select start time.',
                
            },
             'event[event_end_date]': {
                required: 'Please select end time.',
                
            }
        },
	    highlight: function(element) {
            $(element).removeClass("error");
        }
    });
    
    // start of feed page js
    

   window.globalVariable = [];
   window.globalVariableforComment = [];

    $(document).on('click', '.post-delete', function() {
      if (confirm("Do you want to delete post ?")) {
        var toid = $(this).attr('data-id');

        var that = this;
        $.ajax({
          type: "DELETE",
          url: '/deletepost/', //sumbits it to the given url of the form
          dataType: "HTML",
          data: {postid: toid},
          beforeSend: function(xhr) {
            xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
          },
          success: function(data) {
          // $('#' + data).fadeOut();
            $(that).parent().parent('div').fadeOut();

            $('.flash-message').html('<div class="alert alert-success"> Post has been deleted successfully</div>').show();
          },
          error: function(xhr, ajaxOptions, thrownError) {
            $('.flash-message').html('<div class="alert alert-danger"> Please Try again</div>').show();
            console.log(thrownError)

          }

        });
      }
    });


    $(document).on('click', '.post_comment', function(e) {
      var that = $(this);
      console.log(globalVariableforComment);
      var textnew = $(this).siblings('textarea').val(); 
      var textold = $(this).siblings('textarea').val();
      if (globalVariableforComment.length > 0 ) {
       $.each(globalVariableforComment, function( key, valu ) {   
         textnew  =    textnew.replace(valu.key, valu.value);
         console.log(textnew);
       });  
     
      }
        var text = textnew!='' ? textnew : textold
        if (text == '') {
		  $(this).siblings('textarea').attr('placeholder',"Don't forget to type your comment");	
          return false;
        }
        var postid = $(this).attr('data-id');
 
        $.ajax({
          type: "POST",
          url: '/create_comment/', //sumbits it to the given url of the form
          data: {text: text, post: postid},
          dataType: "HTML",
          beforeSend: function(xhr) {
            xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
          }
        }).success(function(data) {
          $("#cmt" + postid + " .comment_container").append(data);
         that.siblings('textarea').val('');
         	var height = that.parent().parent().find('.comment_container').height() + that.parent().parent().find('.add_comment').height() + 37;
			that.parent().parent().css('height',height).find('.add_comment textarea').attr('placeholder',"Start commenting here...").val('').focus();


        });

     

    });

    var options = {
      type: "POST",
      url: '/create_post/', //sumbits it to the given url of the form
      dataType: "HTML",
      beforeSubmit: beforeSubmit,
      success: function(data) {
        $("#feed").prepend(data);
        $("#photo").val('');
        $("#video").val('');
        $(".posttext").val('');
        $('.post_type').remove();
        $('.lnk').html('')
      },
      error: function(xhr, ajaxOptions, thrownError) {
        console.log(JSON.stringify(xhr, null, 4));
        $('.flash-message').html('<div class="alert alert-danger"> Please Try again!').show();
      }


    };

    $("#share_post").click(function(e) {
     console.log(globalVariable);
      var posttextnew = $('.posttext').val(); 
      var postextold = $('.posttext').val();
      if (globalVariable.length > 0 ) {
       $.each(globalVariable, function( key, valu ) {   
         posttextnew  =    posttextnew.replace(valu.key, valu.value);
         console.log(posttextnew);
       });       
      }         
     $('#posttext').val(posttextnew!='' ? posttextnew : postextold) 
     if ($('.post_type').val() == 'link') {
		 $('#posttext').val($('.lnk').html());
	 }	 
      e.preventDefault();     
      $('#update_post').ajaxSubmit(options);
    });


    $(document).on('click','.comment-delete', function() {
      if (confirm("Do you want to delete comment?")) {
        var toid = $(this).attr('data-id');

        var mydata = {'id': toid};
        var that = this;
        $.ajax({
          type: "DELETE",
          url: '/deletecomment/', //sumbits it to the given url of the form
          dataType: "HTML",
          data: mydata,
          beforeSend: function(xhr) {
            xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
          },
          success: function(data) {
            $('#scont' + data).fadeOut();
            $('.flash-message').html('<div class="alert alert-success"> Comment has been deleted successfully</div>').show();
          },
          error: function(xhr, ajaxOptions, thrownError) {
            $('.flash-message').html('<div class="alert alert-danger"> Please Try again</div>').show();
            console.log(thrownError)

          }

        });
      }
    });

 $(".add_comment").on('keyup', 'textarea',function(e) {
  var that = this
    if ($(this).val().indexOf("@") != -1) {
      var ind = $(this).val().indexOf("@");
      var keywords = $(this).val().substr(ind + 1);
     
      if (keywords != '') {

        $.ajax({
          type: "POST",
          url: '/search_user/' + keywords + '/type/ /' + 'post', //sumbits it to the given url of the form
          dataType: "HTML",
          beforeSend: function(xhr) {
            xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
          },
          success: function(data) {
         
            $(that).siblings('.arport2').show()
            $(that).siblings('.arport2').html(data)


          },
          error: function(xhr, ajaxOptions, thrownError) {
            console.log(xhr.status)

          }

        });
      }
    }else {
    $(that).siblings('.arport2').hide()
    }
  });
  
  $(document).on('click', '.postkudos', function(e) {
	  
          var postid = $(this).attr('data-id');
          var classs = $(this).children('div').attr('class');
          var that = $(this);
	      $.ajax({
          type: "POST",
          url: '/give_kudos/', //sumbits it to the given url of the form
          data: {post_id: postid},
          dataType: "HTML",
          beforeSend: function(xhr) {
            xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
          }
          }).success(function(data) {
			  if (data == 1) {
			    	$(that).children('div').toggleClass('icon icon-liked');			
			  }	
        });

    });

  
    $(document).on("click", '.show_comment', function() {
      if ($(this).parent().siblings('.comment_box').is(':hidden')) {
        $(this).parent().siblings('.comment_box').slideDown();
        $(this).parent().siblings('.comment_box').children('.add_cmnt').val('');
      } else {
        $(this).parent().siblings('.comment_box').slideUp();
      }
    });
    
// pagination code
	  if ($('.pagination').length) {	
		$(window).scroll(function() {			
		 var url = $('.pagination .next_page').attr('href');
		  if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 50) {			
			$('.pagination').text("Please Wait...");
			return $.getScript(url);
		  }
		});
		return $(window).scroll();
	  }
	  
	     $("#gym_class_form").validate({
        rules: {
            'specialty_id': {
                required: true,
              },
              'trainer_id':{
             required: true,
                 
              },
              'class_time' :{
                required: true,
              },
              'duration' :{
                required: true,
              },
              'class_date' :{
                required: true,
              },
              'total_slot' :{
                required: true,
              }
        },
        messages: {
            'specialty_id': {
                required: 'Please enter text.',
                
            },
              'trainer_id':{
                required: 'Please select trainer.',
               
              },
              'class_time' :{
                required: 'Please select class time.',
              },
              'duration' :{
                required: 'Please select duration.',
              },
              'class_date' :{
                required: 'Please select class date.',
              },
              'total_slot' :{
                required: 'Please select total slot.',
              }
        },
	  
    }); 
    
         $("#gym_trainers_form").validate({
        rules: {
            'trainer_id':{
             required: true,
                 
              },
              'appointment_date' :{
                required: true,
              },
              'total_slot' :{
                required: true,
              }
        },
        messages: {
             'trainer_id':{
                required: 'Please select trainer.',
               
              },
              'appointment_date' :{
                required: 'Please select date.',
              },
              'total_slot' :{
                required: 'Please select total slot.',
              }
        },
	  
    });
    
 
 
   
}); // end of document dot ready


	
	
var source;
var source2;

//sse();  
setTimeout(function () {
  //sse();

}, 60000);








function sse() {
    if (typeof (EventSource) !== "undefined") { //check for browser support
        if (typeof source != "undefined") {
            source.close();
        }
        source = new EventSource("checkmsgcount");
        source.onmessage = function (event) {  //detect message receipt
              if (!event) {
       source.close();
   } else {
   
            var output = JSON.parse(event.data);
            //console.log(output.totalMsg);
            if (0 != output.totalMsg) {
                $('#newmsg').html(output.totalMsg).fadeIn();

            }
   }
        };
    } else {
        alert("Whoops! Your browser doesn't  receive server-sent events.");
    }
}

//function to check file size before uploading.
  function beforeSubmit() {

    if ($('.posttext').val() == '') //check empty input filed
    {
      $('.flash-message').html('<div class="alert alert-danger"> Please Enter Text!').show();
      return false;
    }
    //check whether browser fully supports all File API
    if (window.File && window.FileReader && window.FileList && window.Blob)
    {



      if (!$('#photo').val()) //check empty input filed
      {
        return;
      }



      var fsize = $('#photo')[0].files[0].size; //get file size
      var ftype = $('#photo')[0].files[0].type; // get file type


      //allow only valid image file types
      switch (ftype)
      {
        case 'image/png':
        case 'image/gif':
        case 'image/jpeg':
        case 'image/pjpeg':
          break;
        default:
          // $("#output").html("Only png, jpg, gif file formats are allowed.");
          $('.flash-message').html('<div class="alert alert-danger">Only png, jpg, gif file formats are allowed.</div>').show();

          return false
      }

      //Allowed file size is less than 1 MB (1048576)
      if (fsize > 10485760)
      {
        $('.flash-message').html('<div class="alert alert-danger"> Too big Image file! Please reduce the size of your photo using an image editor.').show();

        return false
      }


    }
    else
    {

      $('.flash-message').html('<div class="alert alert-danger"> please upgrade your browser, because your current browser lacks some new features we need!').show();
      return false;
    }
  }
  
     //function to check file size before uploading.
  function before_submit_image(id) {

		//check whether browser fully supports all File API
		if (window.File && window.FileReader && window.FileList && window.Blob){

			

			// image width and height chck
			var p1 = new Promise(function(resolve, reject) {
				
				var ftype = $('#' + id)[0].files[0].type; // get file type
				//allow only valid image file types
				switch (ftype){
					case 'image/png':
					case 'image/gif':
					case 'image/jpeg':
					case 'image/pjpeg':
					break;
					default:
					// $("#output").html("Only png, jpg, gif file formats are allowed.");
					$('.flash-message').html('<div class="alert alert-danger">Only png, jpg, gif formats are allowed.</div>').show();

					reject()
				}
				
				var reader = new FileReader();
				//Read the contents of Image File.
				reader.readAsDataURL($('#' +id)[0].files[0]);
				reader.onload = function (e) {
					//Initiate the JavaScript Image object.
					var image = new Image();
					//Set the Base64 string return from FileReader as source.
					image.src = e.target.result;
					var height = image.height;
					var width = image.width;
			    	if ( width > 1000 || height > 1000) {
					//	$('.flash-message').html('<div class="alert alert-danger"> Image is large.</div>').show();
						//reject();
						resolve();
						console.log('Insided function reject')
					} else {
						console.log('Insided function resolve')
						resolve();
					}
				}
				
			});
			
			

			return p1;
		} else {

			$('.flash-message').html('<div class="alert alert-danger"> please upgrade your browser, because your current browser lacks some new features we need!').show();
			return false;
		}
  }






