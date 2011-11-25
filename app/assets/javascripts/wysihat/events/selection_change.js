jQuery(document).ready(function($) {
  var $doc = $(document);
  if ('selection' in document && 'onselectionchange' in document) {
    var selectionChangeHandler = function() {
      var range   = document.selection.createRange();
      var element = range.parentElement();

      $(element).trigger("selection:change");
    }

    $doc.live("selectionchange", selectionChangeHandler);
  } else {
    var previousRange;

    var selectionChangeHandler = function() {
      var element        = document.activeElement;
      var elementTagName = element.tagName.toLowerCase();

      if (elementTagName == "textarea" || elementTagName == "input") {
        previousRange = null;
        $(element).trigger("selection:change");
      } else {
        var selection = window.getSelection();
        if (selection.rangeCount < 1) { return };

        var range = selection.getRangeAt(0);
        if (range && range.equalRange(previousRange)) {
          return;
        }
        previousRange = range;

        element = range.commonAncestorContainer;
        while (element.nodeType == Node.TEXT_NODE)
          element = element.parentNode;

        $(element).trigger("selection:change");
      }
    };

    $doc.live('mouseup', selectionChangeHandler);
    $doc.live('keyup', selectionChangeHandler);
  }
});
