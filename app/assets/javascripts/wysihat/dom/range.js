//= require "wysihat/dom/ierange"

$.extend(Range.prototype, (function() {
  function beforeRange(range) {
    if (!range || !range.compareBoundaryPoints) return false;
    return (this.compareBoundaryPoints(this.START_TO_START, range) == -1 &&
      this.compareBoundaryPoints(this.START_TO_END, range) == -1 &&
      this.compareBoundaryPoints(this.END_TO_END, range) == -1 &&
      this.compareBoundaryPoints(this.END_TO_START, range) == -1);
  }

  function afterRange(range) {
    if (!range || !range.compareBoundaryPoints) return false;
    return (this.compareBoundaryPoints(this.START_TO_START, range) == 1 &&
      this.compareBoundaryPoints(this.START_TO_END, range) == 1 &&
      this.compareBoundaryPoints(this.END_TO_END, range) == 1 &&
      this.compareBoundaryPoints(this.END_TO_START, range) == 1);
  }

  function betweenRange(range) {
    if (!range || !range.compareBoundaryPoints) return false;
    return !(this.beforeRange(range) || this.afterRange(range));
  }

  function equalRange(range) {
    if (!range || !range.compareBoundaryPoints) return false;
    return (this.compareBoundaryPoints(this.START_TO_START, range) == 0 &&
      this.compareBoundaryPoints(this.START_TO_END, range) == 1 &&
      this.compareBoundaryPoints(this.END_TO_END, range) == 0 &&
      this.compareBoundaryPoints(this.END_TO_START, range) == -1);
  }

  function getNode() {
    var parent = this.commonAncestorContainer;

    while (parent.nodeType == Node.TEXT_NODE)
      parent = parent.parentNode;

    var child; 
    var that = this;
    $.each(parent.children, function(index, child) {
      var range = document.createRange();
      range.selectNodeContents(child);
      child = that.betweenRange(range);
    });

    return $(child || parent);
  }

  return {
    beforeRange:  beforeRange,
    afterRange:   afterRange,
    betweenRange: betweenRange,
    equalRange:   equalRange,
    getNode:      getNode
  };
})());
