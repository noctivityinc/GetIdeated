jQuery(document).ready(function($) {
  function fieldChangeHandler(event, element) {
    var $element = $(element);

    var value = $element.val();
    if ($element.attr('contentEditable') === 'true') {
      value = $element.html();

      // update the textarea
      $element.next().val(value);
    } 

    // TODO: where did previousValue come from? Guessing it's with contentEditable
    if (value && element.previousValue != value) {
      $element.trigger("field:change");
      element.previousValue = value;
    }
  }

  $('input,textarea,*[contenteditable=""],*[contenteditable=true]').live('keyup', function (event) {
    fieldChangeHandler(event, this);
  });
});
