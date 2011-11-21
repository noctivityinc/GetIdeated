$(function() {
  
  $('.section form').bind('ajax:success', function(evt, data, status, xhr) {
    // reload the partial
    $('.version_list').load($(this).attr('data-version-list'), function(res) {
      if($('.version_list .version:first .content').text() != data.content)
        $('.version_list .version:first').hide().slideDown();
    });
  });

});