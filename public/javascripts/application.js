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
  $('.delete-status').bind('click', function() {
      var deleteStatus = $(this);
      $(this).after('<p class="confirm-delete-status"><a href="#">delete?</a></p>')
      $(this).css({backgroundPosition: '-16px -16px'});
      $(this).parent().children(".confirm-delete-status").fadeIn();
      $(this).parent().children(".confirm-delete-status").bind('click', function() {
        $.ajax({
          type: "POST",
          url: $(this).parent().parent().attr("action"),
          data: "_method=delete&authenticity_token=" + $('meta[name=csrf-token]').attr('content'),
          success: function(data) {
            deleteStatus.parent().parent().parent().fadeOut();
          }
        });
        return false;
      });
      $(':not(this)').bind('click', function() {
        deleteStatus.next().fadeOut();
        $('.delete-status').css({backgroundPosition: '-16px 0'});
      });
      return false;
  });


  $( "#slider-range" ).slider({
    range: true,
    min: 0,
    max: 500,
    values: [ 75, 300 ],
    slide: function( event, ui ) {
      $( "#amount" ).val( "$" + ui.values[ 0 ] + " - $" + ui.values[ 1 ] );
    }
  });
  $( "#amount" ).val( "$" + $( "#slider-range" ).slider( "values", 0 ) +
                     " - $" + $( "#slider-range" ).slider( "values", 1 ) );




});
