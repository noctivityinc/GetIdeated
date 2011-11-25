jQuery(document).ready(function($) {

  $('.nav_stats span').live('click', function(ev) {
    ev.preventDefault();
    var url = $(this).attr('data-href');
    location.href = url;
  });

  $('a.show_description').click(function(e) {
    e.preventDefault();

    var $self = $(this);
    var $section = $(this).closest('.section');
    var $description = $section.find('.description');
    $description.toggle('fast', function(){
      $self.text($description.is(':visible') ? 'Hide Help ' : 'Show Help');   
    });
  });

  $('.section .description').each(function() {
    var $section = $(this).closest('.section');
    $section.find('a.show_description').text($(this).is(':visible') ? 'Hide Help ' : 'Show Help'); 
  });

  $('#new_comment').live('ajax:success', function(evt, data, status, xhr) {
    $('.comments_list').html(data);
    $('.comment:first').effect("highlight", {}, 1500);
    $('#new_comment textarea').val('');
  });

  $('.comment .trash a').live('ajax:success', function(evt, data, status, xhr) {
    $('.comments_list').html(data);
  });

  $('.add_toggle').after(function(){
       if ($(this).is(":checked")) {
         return "<a href='#' class='toggle checked' ref='"+$(this).attr("id")+"'></a>";
       }else{
         return "<a href='#' class='toggle' ref='"+$(this).attr("id")+"'></a>";
       }
       
       
     });
     
   /*
    When the toggle switch is clicked, check off / de-select the associated checkbox
   */
  $('.toggle').click(function(e) {
     var checkboxID = $(this).attr("ref");
     var checkbox = $('#'+checkboxID);

     if (checkbox.is(":checked")) {
       checkbox.removeAttr("checked");

     }else{
       checkbox.attr("checked","true");
     }
     $(this).toggleClass("checked");

     e.preventDefault();

  });
});