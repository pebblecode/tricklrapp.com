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
  $("#queued_statuses").sortable({ handle: '.reorder-statuses' });

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


  /*
   * Status character countdown
  */
  $('#status_submit').after('<p class="count">140</p>');
  $('textarea#status_status').focus();
  $('textarea#status_status').keyup(function() {
      var statusLength = $(this).val().length;
      $('.count').html(140 - statusLength);
      if($(this).val().length > 130) {
        $('.count').addClass('status-count-warning');
      }
      if($(this).val().length < 130) {
        $('.count').removeClass('status-count-warning');
      }
    });

  /*
   * Show and hide status lists
  */
  $('li.queued-statuses').live('click', function() {
    $(this).addClass("selected");
    $('li.published-statuses').removeClass("selected");
    $('#published_statuses').fadeOut('fast', function() {
      $('#queued_statuses').show();
    });
    return false;
  });
  $('li.published-statuses').live('click', function() {
    $(this).addClass("selected");
    $('li.queued-statuses').removeClass("selected");
    $('#queued_statuses').fadeOut('fast', function() {
      $('#published_statuses').show();
    });
    return false;
  });

});
