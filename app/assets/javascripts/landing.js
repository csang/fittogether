$(document).ready(function() {
	$('#login_container p span').click(function(event) {
		$('#register_container').show();
		$('#forgot_container').hide();
		$('#login_container').hide();
		
	});
	$('#register_container p span').click(function(event) {
		$('#login_container').show();
		$('#register_container').hide();
		$('#forgot_container').hide();
	});
	$('#register_container #register_view ul li').click(function(event) {
		for (var i = 0; i < $('#register_container #register_view ul .select').length; i++) {
			$($('#register_container #register_view ul .select')[i]).removeClass('select');
		};
		$(this).addClass('select');
		$('#register_container #register_view input[name="register_account_type"]').val($(this).attr('data-index'));
	});
	$('#fp').click(function(event) {
		$('#forgot_container').show();
		$('#login_container').hide();
	});
	$('#forgot_container p ').click(function(event) {
		$('#forgot_container').hide();
		$('#register_container').hide();
		$('#login_container').show();
	});
});
