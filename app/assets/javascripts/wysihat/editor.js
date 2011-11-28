/** section: wysihat
 * WysiHat.Editor
 **/
WysiHat.Editor = {
    /** section: wysihat
     *  WysiHat.Editor.attach(textarea) -> undefined
     *  - $textarea (jQuery): a jQuery wrapped textarea that you want to convert
     * to a rich-text field.
     *
     *  Creates a new editor for the textarea.
     **/
    attach: function($textarea) {
        var $editArea;

        var id = $textarea.attr('id') + '_editor';
        if ($editArea == jQuery('#' + id)) {
            return $editArea;
        }

        $editArea = jQuery('<div id="' + id + '" class="editor" contentEditable="true"></div>');
        
        // $editArea.html(WysiHat.Formatting.getBrowserMarkupFrom($textarea.val()));
        $editArea.html($textarea.html());

        jQuery.extend($editArea, WysiHat.Commands);

        $textarea.before($editArea);
        $textarea.hide();

        // WysiHat.Editor.setEndOfContenteditable($editArea.get(0));

        // WysiHat.BrowserFeatures.run()
        return $editArea;
    },

    init: function($editArea, id) {
      jQuery.extend($editArea, WysiHat.Commands);

      // create hidden field
      var $hiddenField = jQuery('<input type="hidden"></input').attr('id', id).attr('name', id).val($editArea.html());
      $editArea.after($hiddenField);

      return $editArea;
    },

    setEndOfContenteditable: function($editArea) {
        var contentEditableElement = $editArea.get(0);
        var range, selection;
        if (document.createRange) //Firefox, Chrome, Opera, Safari, IE 9+
        {
            range = document.createRange(); //Create a range (a range is a like the selection but invisible)
            range.selectNodeContents(contentEditableElement); //Select the entire contents of the element with the range
            range.collapse(false); //collapse the range to the end point. false means collapse to end rather than the start
            selection = window.getSelection(); //get the selection object (allows you to change selection)
            selection.removeAllRanges(); //remove any selections already made
            selection.addRange(range); //make the range you have just created the visible selection
        } else if (document.selection) //IE 8 and lower
        {
            range = document.body.createTextRange(); //Create a range (a range is a like the selection but invisible)
            range.moveToElementText(contentEditableElement); //Select the entire contents of the element with the range
            range.collapse(false); //collapse the range to the end point. false means collapse to end rather than the start
            range.select(); //Select the range (make it the visible selection
        }
    }
};