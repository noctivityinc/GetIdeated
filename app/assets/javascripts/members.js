jQuery(document).ready(function($) {
  $('.add_member').click(function(e) {
    e.preventDefault();
    loadInviteForm();
  });

  $('.members .member:odd').css('background-color', '#f0f0f0');

  $('.new_invite form').live('ajax:success', function(evt, data, status) {
    var res = $.parseJSON(data);

    $('#left_nav').html(res.left_nav)
    $('.list').html(res.list);
    $('#invitations .invite:first').effect("highlight", {}, 1500);
    $('.new_invite').html('');
  }).live('ajax:complete', function(evt, data, status) {
    if(status == 'error') {
      $('.new_invite').html(data.responseText)
    }
  }).find('.cancel').live('click', function(e) {
    e.preventDefault();
    $('.new_invite').html('');
  });;

  function loadInviteForm () {
    var url = $('.new_invite').attr('data-new-invite-url');
    $('.new_invite').load(url, function() {
      $('#invite_email').focus();
    })
  }

});

