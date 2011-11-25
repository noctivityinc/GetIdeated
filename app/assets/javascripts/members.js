jQuery(document).ready(function($) {
  $('.add_member').click(function(e) {
    e.preventDefault();
    loadInviteForm();
  });

  $('.new_invite form').live('ajax:success', function(evt, data, status) {
    $('.list').html(data);
    $('.new_invite').html('');
  }).live('ajax:complete', function(evt, data, status) {
    if(status == 'error') {
      $('.new_invite').html(data.responseText)
    }
  }).find('.cancel').live('click', function(e) {
    e.preventDefault();
    $('.new_invite').html('');
  });;

  $('.remove').live('click',function(e) {
    e.preventDefault();

    var url = $(this).attr('href');
    $('.list').load(url, {_method: 'DELETE'});
  });

  $('.uninvite').live('click',function(e) {
    e.preventDefault();

    var url = $(this).attr('href');
    $('.list').load(url, {_method: 'DELETE'});
  });
});

function loadInviteForm () {
  var url = $('.new_invite').attr('data-new-invite-url');
  $('.new_invite').load(url)
}
