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
});
