/*
 * Fades flash notices out after they are shown
*/
jQuery.fn.flashNotice = function () {
  jQuery(this).hide();
  jQuery(this).fadeIn();

  var element = jQuery(this);
  var timeout = setTimeout(function () { element.fadeOut(); }, 3000);

  jQuery(this).click(function () {
    clearTimeout(timeout);
    jQuery(this).fadeOut();
  });
};


$(document).ready(function() {
  /* 
  * Fade flash notices
  */
  $(".flash-notice").flashNotice();  

  /*
  * Make tweet list sortable
  */
  $("#status-list").sortable({ handle: '.reorder-statuses' });

  /* 
  * Pretty delete messages
  */
  $('.delete-status').click(function() {
      $(this).after('<a href="#" class="confirm-delete-status">delete?</a>');
      $(':not(.confirm-delete-status)').click(function() {
        $('.confirm-delete-status').hide();
      });
      $('.confirm-delete-status').click(function() {
        $('.confirm-delete-status').parent().fadeOut('slow');
        return false;
      });
      return false;
  });
});
