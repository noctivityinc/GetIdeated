jQuery(document).ready(function($) {

    $('.section form').live('ajax:success', function(evt, data, status, xhr) {
        // reload the partial
        $('.version_list').load($(this).attr('data-version-list'), function(res) {
          $('.version_list .version:first').hide().slideDown();
        });
    });

    $('.revert a').live('ajax:before', function (argument) {
      
    }).live('ajax:success', function(evt, data, status, xhr) {
        var res = $.parseJSON(xhr.responseText);

        $('.section').html(res.section);
        $('.version_list').html(res.versions);
        $('.version_list .version:first').hide().slideDown();
    });
  
});