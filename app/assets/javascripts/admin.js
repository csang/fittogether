$(document).ready(function() {
	$('.change_status').on('change',function(){
		var status = $('.change_status').val();
		var dataId = $(this).attr('data-id');
		var model = $(this).attr('data-model');
			$.ajax({
					url:BASE_URL+'admin/accounts/status',
					type : 'post',
					data: { id : dataId , status : status, model : model },
					async: true,
					success:function(resp){
							if(1 == resp)
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
    $("#checkall").on('click', function() {
        $(".check").prop("checked", this.checked);
    });

    $(".check").on('click', function() {

        if ($(".check").length == $(".check:checked").length) {
            $("#checkall").prop("checked", true);
        } else {
            $("#checkall").prop("checked", false);
        }
    });    
	  $(".bulk-form").submit(function() {
            return validatemultipleaction();
      });
 
    $(".edit_account").validate({
        rules: {
            'account[first_name]': {
                required: true
            },
            'account[last_name]': {
                required: true
            },
            'account[user_name]': {
                required: true
            },
            'account[account_url]': {
                required: true,
                url: true
            },
            'account[profession_id]': {
                required: true
            },
           'account[company]':{
               required:true, 
            },
            'account[industry_id]':{
               required:true, 
            },
            'account[gym_id]':{
                required : true
            },
            'account[goals]':{
                required : true
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
            'account[account_url]': {
                required: 'Please enter account url',
            },
            'account[profession_id]': {
                required: 'Please select profession'
            },
           'account[company]':{
               required:'Please select company', 
            },
            'account[industry_id]':{
               required:'Please select industry', 
            },
           'account[gym_id]':{
                required : 'Please select gym'
            },
            'account[goals]':{
                required:'Please select goals'
            }
        },
            highlight: function(element) {
            $(element).removeClass("error");
        }
    });

});

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
   
    if (count < 1) {
        $("#checkerr").html('Please select atleast one record');
        $("#checkerr").show();
        return false;
    }
    
    if (PageOptions == 'Delete' && !confirm('Are you sure you want to delete' + appmessage)) {
            return false;
    }

    if (PageOptions == 'Active' && !confirm('Are you sure you want to Active'  + appmessage)) {
            return false;
    }

    if (PageOptions == 'Inactive' && !confirm('Are you sure you want to Inactive' + appmessage) ) {
            return false;
    }
}
function adminFlashMsgs(msg, errorClass) {	
	$('.flashMessage').html('');
    $('.flashMessage').append("<div class='"+errorClass+"'><button aria-hidden='true' data-dismiss='alert' class='close' type='button'>×</button>"+msg+"</div>");
   // $('.flashMessage').effect("shake", {times: 3}, 200);
    setTimeout(function() {
          $('.flashMessage').fadeOut('slow', function() {
               $('.flashMessage').html('');
        });
    }, 5000);

}
