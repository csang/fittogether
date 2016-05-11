$(document).ready(function() {
    /* Validations other rules start*/
    $.validator.addMethod("alphawithspace", function(value, element) {
        return this.optional(element) || value == value.match(/^[-a-zA-Z ]+$/);
    }, "Alphabets only");
    $.validator.addMethod("alpha", function(value, element) {
        return this.optional(element) || value == value.match(/^[a-zA-Z]+$/);
    }, "Alphabets only");
    $.validator.addMethod("alphanumericspecial", function(value, element) {
        return this.optional(element) || value == value.match(/^[a-z0-9A-Z#@$%^&*()!]+$/);
    }, "Only Characters, Numbers & Special Chars Allowed.");
    $.validator.addMethod("phonenumberhy", function(value, element) {
        return this.optional(element) || value == value.match(/^[0-9-]+$/);
    }, "Valid Phone Number");
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
    $('.change_status').on('change', function() {
        var status = $(this).val();
        var dataId = $(this).attr('data-id');
        var model = $(this).attr('data-model');
        $.ajax({
            url: BASE_URL + 'admin/accounts/status',
            type: 'post',
            data: {id: dataId, status: status, model: model},
            async: true,
            success: function(resp) {
                if (1 == resp)
                    adminFlashMsgs('Status has been updated successfully.', 'alert alert-success alert-dismissable');
                else
                    adminFlashMsgs('Status cannot be updated. Please try again  ', 'alert alert-warning alert-dismissable');
            },
            error: function(xhr, ajaxOptions, thrownError) {
                adminFlashMsgs(thrownError, 'alert alert-warning alert-dismissable');
            }
        });
    });

    /* below code is to perform  functionality */
    /*$("table.tablesorter").find('div.tablesorter-header-inner input#checkall').on('click', function() {
     $(".check").prop("checked", this.checked);
     }); */

    $(".check").on('click', function() {

        if ($(".check").length == $(".check:checked").length) {
            $("#checkall").prop("checked", true);
        } else {
            $("#checkall").prop("checked", false);
        }
    });
    
    $("#bid").click(function() {
	
        validatemultipleaction();
			
		
    });
   

    $(".edit_account").validate({
        rules: {
            'account[first_name]': {
                required: true,
                loginRegex: true,
                minlength: 3,
                maxlength: 20
            },
            'account[last_name]': {
                required: true,
                loginRegex: true,
                minlength: 3,
                maxlength: 20
            },
            'account[user_name]': {
                required: true,
                minlength: 3,
                maxlength: 25
            },
            'account[profession_id]': {
                required: true
            },
            'account[industry_id]': {
                required: true,
            },
            'account[gym_id]': {
                required: true
            },
            'account[goals]': {
                required: true
            }
        },
        messages: {
            'account[first_name]': {
                required: 'Please enter first name'
            },
            'account[last_name]': {
                required: 'Please enter last name'
            },
            'account[user_name]': {
                required: 'Please enter user name'
            },
            'account[profession_id]': {
                required: 'Please select profession'
            },
            'account[industry_id]': {
                required: 'Please select industry',
            },
            'account[gym_id]': {
                required: 'Please select gym'
            },
            'account[goals]': {
                required: 'Please select goals'
            }
        },
        highlight: function(element) {
            $(element).removeClass("error");
        }
    });
    
      $('#edit_admin').validate({
		rules:{
				'admin[current_password]'	:{
					required	:	true
				},
				'admin[password]'	:{
					required	: true,
					minlength   : 8
					
				},
				'admin[password_confirmation]'	:{
					required	: true,
					equalTo: '#admin_password'
					
				}
			},
			messages:{
				
					'admin[current_password]'	:{
						required	:	'Please enter current password.',
					},
					'admin[password]'	:{
						required	: 'Please enter password.',
						minlenght   :   true 
						
					},
					'admin[password_confirmation]'	:{
						required	: 'Please confirm password.',
						equalTo	: 'Password must match confirm password.',
						
					}
				
				}	
			
			
			});
			
	// hide alert message 
   setTimeout(function(){
    $('.alert').fadeOut('slow');
  }, 5000);	
  
  
  /*below block of code is used to validate page form while adding and updating */
	$("#new_cms_page, .edit_cms_page").validate({
		rules		:{
					'cms_page[name]'		:	{
						required	:	true
					},
					'cms_page[meta_title]'	:	{
						required	:	true
					},
					'cms_page[seo_url]'	:	{
						required	:	true,
						url	:	true
					},
					'cms_page[meta_desc]'	:	{
						required	:	true
					},
					'cms_page[meta_keyword]'	:	{
						required	:	true
					}
		},
		messages	:{
					'cms_page[name]'	:	{
						required	:	'Please enter name.'
					},
					'cms_page[meta_title]'	:	{
						required	:	'Please enter meta title.'
					},
					'cms_page[seo_url]'	:	{
						required	:	'Please enter seo url.',
						url	:	'Invalid url.'
					},
					'cms_page[meta_desc]'	:	{
						required	:	'Please enter meta description.'
					},
					'cms_page[meta_keyword]'	:	{
						required	:	'Please enter meta keyword.'
					}
		}
	});


          /*below block of code is used to validate page form while adding and updating */
	$("#location_form").validate({
		rules		:{
					'location[name]'		:	{
						required	:	true
					}
		},
		messages	:{
					'location[name]'	:	{
						required	:	'Please enter city name.'
					}
		}
	});  
}); //end of document dot ready

function validatemultipleaction() {
   
    var count = $(".check:checked").length;
    var counter = $(".check").length;
    var PageOptions = $(".options").val();
    var appmessage = " " + count + " record(s) ?";
    if (PageOptions == '') {
        $("#checkerr").html('Please select action');
        $("#checkerr").show();
        $(".options").focus();
        return false;
    }
	   
   else if (count < 1) {
        $("#checkerr").html('Please select atleast one record');
        $("#checkerr").show();
        return false;
    }   

   else if (PageOptions == 'Active' && !confirm('Are you sure you want to Active' + appmessage)) {
        return false;
    }

   else if (PageOptions == 'Inactive' && !confirm('Are you sure you want to Inactive' + appmessage)) {
        return false;
    }
    
   else if (PageOptions == 'Delete' && confirm('Are you sure you want to delete' + appmessage)) {
 
        var Data = {}; 
       Data.client_id = clientid;
       Data.client_secret = secertid;
       Data.grant_type = "client_credentials";
       $.ajax({
       url: 'https://fittogetherzap.auth0.com/oauth/token',
	   type: 'POST',
	   contentType: 'application/json',
	   dataType: 'json',
	   data: JSON.stringify(Data),
	   success: function(xhr, status) {
        newtoken = 'Bearer ' + xhr.access_token;
        
		$(".check:checked").each(function()
		{
		aprovider = $(this).attr('dataprovider');		
		adataId = $(this).attr('dataid');
               
		userid = aprovider +'|' + adataId;    
             
                          
                             $.ajax({
                               url: 'https://fittogetherzap.auth0.com/api/users/'+userid,
                               type: 'DELETE',
                               contentType: 'application/json',
                               dataType: 'json',
                               data: JSON.stringify(Data),
                               beforeSend: function(xhr) {
                                 xhr.setRequestHeader('Authorization', newtoken);
                                 $('.flash-message').html('');
                               },
                               success: function(data) {
							   console.log(data)
                               }
                             });
                          
		
		 });  // end of checked
		
		  
		 },
		   error: function(xhr, ajaxOptions, thrownError) {
			  
			 console.log(xhr)
		   },
         });
      setTimeout( function(){
      
       $('.bulk-form').submit();
	},3500);
    } else {
   
		 $('.bulk-form').submit();
	 }
    
}
function adminFlashMsgs(msg, errorClass) {
    $('.flashMessage').html('');
    $('.flashMessage').append("<div class='" + errorClass + "'>" + msg + "</div>").show();
    setTimeout(function() {
        $('.flashMessage').fadeOut('slow', function() {
            $('.flashMessage').html('');
        });
    }, 3000);

}
