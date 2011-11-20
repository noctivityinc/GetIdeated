$(function() {
  $('.section .controls .edit, .version').click(function(e) {
    e.preventDefault();

    resetSections();
    $(this).closest('.section')
    .find('form').show().end()
    .find('.version').hide().end()
    .find('.edit').hide();
  });

  $('.section .cancel').click(function(e) {
    e.preventDefault();

    resetSections();
  });

  $('.section form').bind('ajax:success', function(evt, data, status, xhr) {
    var $section = $(this).closest('.section');

    $(this).hide();
    $section.find('.version').text(data.content).effect("highlight", {}, 1500);;
    $section.find('.edit').show();
    $section.find('input[type=checkbox]').val('0').removeAttr("checked"); 
  });
});

function resetSections () {
  $('.section')
    .find('form').hide().end()
    .find('.version').show().end()
    .find('.edit').show();
}