$(function() {
  $('.section .controls .edit, .section .version').live('click', function(e) {
    e.preventDefault();
    
    var $section = $(this).closest('.section');
    resetSections();

    $section
    .find('.version').hide().end()
    .find('.edit').hide().end()
    .find('form').show().find('textarea').focus();
  });

  $('.section .cancel').live('click', function(e) {
    e.preventDefault();

    resetSections();
  });

  $('.section form').live('ajax:success', function(evt, data, status, xhr) {
    var $section = $(this).closest('.section');
    $section.html(data).effect("highlight", {}, 1500);
  });

  $('.section form textarea').live('keyup', function() {
    var $section = $(this).closest('.section');
    var $charsLeft = $section.find('.chars_left');
    var charsLeft = 1000 - $(this).val().length;
    $charsLeft.html(charsLeft  + ' characters left');

    charsLeft < 10 ? $charsLeft.addClass('danger') : $charsLeft.removeClass('danger');

  })
});

function resetSections () {
  $('.section')
  .find('form').hide().end()
  .find('.version').show().end()
  .find('.edit').show();
}
