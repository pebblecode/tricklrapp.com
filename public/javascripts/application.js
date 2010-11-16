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
  * Makes queued statues sortable
  * See http://docs.jquery.com/UI/Sortable
  */ 
  $('#queued_statuses').sortable({handle: '.reorder-statuses', update: function() {
    $.post('/statuses/sort', '_method=put&authenticity_token='+ $('meta[name=csrf-token]').attr('content')+'&'+$(this).sortable('serialize'));
    }
  });

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

  /*
   * Populates modal form for editing a status
  */
  $('a.edit-status').live('click', function() {
    $('#modal-edit textarea').val($(this).prev().prev().text().trim());
    $('#modal-edit form').attr("action", this.href.replace(/\/edit$/,"") + ".json");
    var csrf = $('meta[name=csrf-token]').attr('content');
    $('#modal-edit form').append("<input type='hidden' value='" + csrf + "' name='authenticity_token'/>")
  });

  /*
   * Listens for a clicks on editing a status and creates an overlay
  */
  var triggers = $("a.edit-status").overlay({

    mask: {
      color: '#000',
      loadSpeed: 200,
      opacity: 0.8
    },

    closeOnClick: true
  });

  /*
   * Handles AJAX submission of modal edit box
  */
  $('#modal-edit input[type=submit]').live('click', function() {
    $(this).before('<img src="/images/ajax/ajax-loader.gif" id="ajax-loader" />')
    var statusId = $('#modal-edit form').attr("action").replace(/[^0-9]*/,"").replace(/.json/, "");
    $.ajax({
      type: 'POST',
      url: $('#modal-edit form').attr("action"),
      data: $('#modal-edit form').serialize(),
      cache: false,
      success: function(data){
        $('#ajax-loader').remove();
        $('#modal-edit').fadeOut();
        $('#exposeMask').fadeOut('slow', function() {
          $('li#status-' + statusId +' p').text(data.status.status);
          $('li#status-' + statusId +'').effect("highlight", {}, 1500);
        });
      }
    });
    return false;
  });

  //$('#new-status input[type=submit]').live('click', function() {
  //  $(this).parents('form:first').submit();
  //  $('#things').prepend('<%=escape_javascript render(@thing) %>');
  //});

});
