/*
 * This is a manifest file that'll be compiled into including all the files listed below.
 * * Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
 * * be included in the compiled file accessible from http://example.com/assets/application.js
 * * It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
 * * the compiled file.
 *= require jquery.min
 *= require jquery-ui-1.8.16.custom.min
 *= require_tree ./libs
 * Fades flash notices out after they are shown
*/

var Config = {
  countdownRangeIntervals: [
    // 0-60sec -> 1s interval
    {
      max: 60 * 1000,
      interval: 1000
    },

    // 1min-5min -> 1min interval
    {
      max: 5 * 60 * 1000,
      interval: 60 * 1000
    },

    // 5min-10min -> 5min interval
    {
      max: 10 * 60 * 1000,
      interval: 5 * 60 * 1000
    },

    // 10min-30min -> 10min interval
    {
      max: 30 * 60 * 1000,
      interval: 10 * 60 * 1000
    },

    // 30min-1hr -> 30min interval
    {
      max: 60 * 60 * 1000,
      interval: 30 * 60 * 1000
    },

    // 1hr-1day -> 1hr interval
    {
      max: 24 * 60 * 60 * 1000,
      interval: 60 * 60 * 1000
    },

    // 1day-forever -> 1day interval
    {
      max: Number.MAX_VALUE,
      interval: 24 * 60 * 60 * 1000
    },
  ]
};

var App = {};

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
jQuery.timeago.settings.allowFuture = true;

$.fn.statusCount = function(){
  var tcoSize = 20;
  var maxStatusSize = 140;
  var statusBox = this;
  var countBox = $('#char-count');
  var contentSize = statusBox.val().length;
  countBox.text(maxStatusSize);
  this.live('keyup', function(){
    var urlRegex = /(^|\s)((https?:\/\/)?[\w-]+(\.[\w-]+)+\.?(:\d+)?(\/\S*)?)/gi;
    var contentSize = statusBox.val().length;
    var text = statusBox.val();
    // detect links
    var links = text.match(urlRegex);
    if (links != null) {
      var totalLinks = links.length;
      var totalLinkSize = links.join('').replace(/\s/g, '').length;
      var totaltcoSize = totalLinks * tcoSize;
      contentSize = contentSize - totalLinkSize + totaltcoSize;
    };
    var remainder = maxStatusSize - contentSize;
    countBox.text(remainder);
    if (remainder < 0) {
      countBox.addClass('negative');
    }else{
      countBox.removeClass('negative');
    };
    
  });
};



$(document).ready(function() {

  /* 
  * Slideshow using http://slidesjs.com/ 
  * play = time for each slide
  */
  $("#slides").slides({
    play: 5500,
  });
  



  /* 
  * Fade flash notices
  */
  $(".flash-notice").flashNotice();  

  /*
  * Makes queued statues sortable
  * See http://docs.jquery.com/UI/Sortable
  */ 
  $('#queued_statuses').sortable({handle: '.reorder-statuses', update: function() {
    $.post('/statuses/sort', '_method=put&authenticity_token='+ $('meta[name=csrf-token]').attr('content')+'&'+$(this).sortable('serialize'),
    function(data){
      $.each(data, function(index, status) {
        cssIndex = index+1
        timeString = jQuery.timeago(status.scheduled_at).replace(/about/,"").replace(/from now/, "");
        $('#queued_statuses li:nth-child('+cssIndex +') div.meta em.ttp').text("posting in about " + timeString).effect("highlight", {}, 1500);
      });

    });
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
  $('#status_submit').before('<p id="char-count"></p>');
  if($('#status_status').length > 0){
    $('#status_status').statusCount();
  }
  
  
  /*
   * Show and hide status lists
  */
  //$('li.queued-statuses').live('click', function() {
  //  $(this).addClass("selected");
  //  $('li.published-statuses').removeClass("selected");
  //  $('#published_statuses').fadeOut('fast', function() {
  //    $('#queued_statuses').show();
  //  });
  //  return false;
  //});

  /*
   * Fetches published statuses via AJAX and writes them
  * to the DOM when a user clicks the Published tab
  */
  //$('#view-links li.published-statuses').live('click', function() {
  //  $(this).addClass("selected");
  //  $(this).parent().after('<img src="/images/ajax/ajax-loader.gif" id="ajax-loader" />')
  //  $('#published_statuses').remove();
  //  $('li.queued-statuses').removeClass("selected");
  //  $('#queued_statuses').fadeOut('fast', function() {
  //    $.ajax({
  //      url: "/published.json",
  //      dataType: 'json',
  //      success: function(json){
  //        $('#ajax-loader').remove();
  //        $('.status-lists').append('<ul id="published_statuses" class="status-list"></ul>');
  //        twitterHandle = $('li.avatar a').text();
  //        $.each(json, function(i, status){
  //          timeString = jQuery.timeago(status.status.scheduled_at);
  //          html = '<li><p>'+ status.status.status +'</p><span class="orange"><a href="http://twitter.com/'+ twitterHandle +'/status/'+ status.status.twitter_id +'">' + timeString + '</a></span></li>';
  //          $(html).hide().prependTo("#published_statuses").fadeIn("slow");
  //        });

  //      }
  //    });
  //  });
  //  return false;
  //});

  /*
   * Fetches published statuses via AJAX and writes them
  * to the DOM when a user clicks the Published tab
  */
  //$('#view-links li.queued-statuses').live('click', function() {
  //  $(this).addClass("selected");
  //  $(this).parent().after('<img src="/images/ajax/ajax-loader.gif" id="ajax-loader" />')
  //  $('#queued_statuses').remove();
  //  $('li.published-statuses').removeClass("selected");
  //  $('#published_statuses').fadeOut('fast', function() {
  //    $.ajax({
  //      url: "/statuses.json",
  //      dataType: 'json',
  //      success: function(json){
  //        $('#ajax-loader').remove();
  //        $('.status-lists').append('<ul id="queued_statuses" class="status-list"></ul>');
  //        twitterHandle = $('li.avatar a').text();
  //        $.each(json, function(i, status){
  //          timeString = jQuery.timeago(status.status.scheduled_at);
  //          html = '<li><p>'+status.status.status +'</p><span class="orange"><a href="http://twitter.com/'+ twitterHandle +'/status/'+ status.status.twitter_id +'">' + timeString + '</a></span></li>';
  //          $(html).hide().prependTo("#queued_statuses").fadeIn("slow");
  //        });

  //      }
  //    });
  //  });
  //  return false;
  //});
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
  //var triggers = $("a.edit-status").overlay({

  //  mask: {
  //    color: '#000',
  //    loadSpeed: 200,
  //    opacity: 0.8
  //  },

  //  closeOnClick: true
  //});

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
          $('li#status_' + statusId +' p').fadeOut('slow', function() {
            $('li#status_' + statusId +'').effect("highlight", {}, 1500);
            $(this).text(data.status.status).fadeIn();
          });
        });
      }
    });
    return false;
  });

  //$('#new-status input[type=submit]').live('click', function() {
  //  $(this).parents('form:first').submit();
  //  $('#things').prepend('<%=escape_javascript render(@thing) %>');
  //});
  $('ul#queued_statuses').ready(function() {
    $('ul#queued_statuses li .actions').prepend('<li class="move"><a href="#" class="icon move reorder-statuses" title="Move">Reorder</a></li>');
  });
  
  // qTips - link tooltips
  $("ul.actions li a[title], ul.actions li form div input[title]").qtip({
    position: {
      corner: {
        target: 'bottomMiddle',
        tooltip: 'topMiddle'
      }
    },
    style: { 
      padding: 5,
      background: '#29abe2',
      color: 'white',
      textAlign: 'center',
      border: false,
      width: 65,
      tip: {
        corner: 'topMiddle',
        color: '#29abe2',
        size: {x:11, y:5}
      }
    }
  });
  $()
  // jQuery UI Slider - http://www.filamentgroup.com/lab/update_jquery_ui_slider_from_a_select_element_now_with_aria_support/
  if ($('#setting_publish_from_4i, #setting_publish_until_4i').length > 0) {
    $('#setting_publish_from_4i').selectToUISlider({
      labels: 0,
      tooltip: false,
      sliderOptions: {
          change: function(){
            var from = Number($('#setting_publish_from_4i').val());
            var until = Number($('#setting_publish_until_4i').val());
            console.log($('#setting_publish_until_4i').val());
            if(from > 12){
              from = (Number(from) - 12)
              from = "" + from + ":00pm";
            }else{
              from = from + ":00am";
            };

            if (until > 12) {
              until = Number(until) - 12;
              until = until + ":00pm";
            }else{
              until = until + ":00am";
            };
            str = "Publish between " + from + " and " + until;
            $("#publish-between").text(str);
          }
        }
    }).hide();
    $('#setting_publish_until_4i').selectToUISlider({
      labels: 0,
      tooltip: false,
      sliderOptions: {
        change: function(){
          var from = Number($('#setting_publish_from_4i').val());
          var until = Number($('#setting_publish_until_4i').val());
          if(Number(from) > 12){
            from = (Number(from) - 12)
            from = "" + from + ":00pm";
          }else{
            from = from + ":00am";
          };
          
          if (Number(until) > 12) {
            until = Number(until) - 12;
            until = until + ":00pm";
          }else{
            until = until + ":00am";
          };
          str = "Publish between " + from + " and " + until
          $("#publish-between").text(str)
        }
      }
    }).hide();
    $('#setting_publish_from_5i').hide();
    $('#setting_publish_until_5i').hide();
  };
  
  // Fade out alert messages after 4 seconds
  if ($('.alert-message').length > 0) {
    setTimeout("$('.alert-message').fadeOut(1000)", 4000);
  };


  if($("#setting_publish_frequency").length > 0){
    $("#setting_publish_frequency").selectmenu({style: 'dropdown'});
  };

  if (navigator.userAgent.toLowerCase().indexOf('chrome') == -1){
    $('a.add-chrome').hide();
  };

  // Set up countdowns
  var countdownCoord = new CountdownCoordinator(Config.countdownRangeIntervals);
  countdownCoord.init();
});

App.tweetsInQueue = function() {
  return $(".status-list > li").length;
};

// Parameters:
//    verbose: if true, displays the complete time. False by default
App.timeToString = function(time, verbose) {
  var timeString = "",
      isVerbose = _.isUndefined(verbose) ? false : verbose,
      days = App.daysInTime(time),
      hrs = App.hoursInTime(time),
      mins = App.minutesInTime(time),
      secs = App.minSecsInTime(time);

  if (isVerbose) {
    timeString += (days > 0) ? days + " days, " + App.dayHoursInTime(time) : hrs;
    timeString += ":";
    timeString += App.hourMinsInTime(time) + ":";
    timeString += App.minSecsInTime(time);
  } else {
    if (days > 0) {
      timeString += "about ";
      timeString += days;
      timeString += " day";
      timeString += ((days == 1) ? "" : "s"); // Pluralise;
    } else if (hrs > 0) {
      timeString += "about ";
      timeString += hrs;
      timeString += " hour";
      timeString += ((hrs == 1) ? "" : "s"); // Pluralise;
    } else if (mins > 0) {
      timeString += "about ";
      timeString += mins + " minute"
      timeString += ((mins == 1) ? "" : "s"); // Pluralise;
    } else {
      timeString += secs;
      timeString += " second";
      timeString += ((secs == 1) ? "" : "s"); // Pluralise
    }
  }

  return timeString;
};

// Get number of days in time in milliseconds
App.daysInTime = function(time) {
  return Math.floor(App.hoursInTime(time) / 24);
};

// Get number of hours in dayly format, of time in milliseconds
App.dayHoursInTime = function(time) {
  return App.hoursInTime(time) % 24;
};

// Get number of hours, in time in milliseconds
App.hoursInTime = function(time) {
  return Math.floor(App.minutesInTime(time) / 60);
};

// Get number of minutes in hourly format, of time in milliseconds
App.hourMinsInTime = function(time) {
  return App.minutesInTime(time) % 60;
};

// Get number of seconds in hourly format, of time in milliseconds
App.minSecsInTime = function(time) {
  return App.secsInTime(time) % 60;
};

// Get number of minutes, in time in milliseconds
App.minutesInTime = function(time) {
  return Math.floor(App.secsInTime(time) / 60);
};

// Get number of seconds, in time in milliseconds
App.secsInTime = function(time) {
  return Math.floor(time / 1000);
}

var CountdownCoordinator = function(config) {
  var _countdowns = {},
      _timeTillPostTemplate = _.template("posting in <%= App.timeToString(time) %>");

  // ------------------------------------------------------
  // Private methods
  // ------------------------------------------------------
  function _updateTimeTillPost(elemId, value) {
    $("#" + elemId).find(".ttp").html(_timeTillPostTemplate({
      time: value
    }));
  };

  // Find the range minimum ie, the range max of the previous countdown range
  // Return first index max range can't be found
  function _countdownRangeMin(countdownRange) {
    var countdownRangeIndex = _.reduce(Config.countdownRangeIntervals, function(memo, cdRange, index) {
      return (cdRange.max === countdownRange.max) ? index : memo;
    }, 0);

    // Get max of previous index
    return (countdownRangeIndex === 0) ?
      _.first(Config.countdownRangeIntervals).max :
      Config.countdownRangeIntervals[countdownRangeIndex - 1].max;
  };

  // Find the first countdown range for the time
  function _countdownRangeForTime(time) {
    var rangeMatch = _.find(Config.countdownRangeIntervals, function(range) {
      return time <= range.max;
    });
    return rangeMatch ? rangeMatch : undefined;
  };

  function _executeCountdown(elemId, countedDown, countdownRange) {
    var timeToGo = _countdowns[elemId] - countedDown;
    // Update time
    _countdowns[elemId] = timeToGo;
    _updateTimeTillPost(elemId, timeToGo);

    // Countdown if there is more time, otherwise remove element
    if (timeToGo > 0) {
      var nextCountdownRange = _countdownRangeForTime(timeToGo);

      console.log(elemId + ": time till next countdown (" + timeToGo + "): " + timeToStringDebug(nextCountdownRange.interval) + " for " + JSON.stringify(nextCountdownRange));

      _.delay(_executeCountdown, nextCountdownRange.interval, elemId, nextCountdownRange.interval, nextCountdownRange);
    } else {
      $("#" + elemId).fadeOut("slow", function() {
        $(this).remove();

        if (App.tweetsInQueue() <= 0) {
          $(".container-tweets").remove();
        }
      });
    }
  };

  function timeToStringDebug(time) {
    return App.timeToString(time, true) + " (" + time + ")";
  };

  // ------------------------------------------------------
  // Public methods
  // ------------------------------------------------------
  this.init = function() {
    var thisCC = this;

    var timeNow = $("body").attr("data-time-now");
    var timeNowDate = new Date(timeNow);
    $(".status-list > li").each(function(index, elem) {
      var elemId = $(elem).attr("id"),
          scheduledAt = $(elem).attr("data-scheduled-at"),
          scheduledAtDate = new Date(scheduledAt),
          timeToGo = (scheduledAtDate.getTime() - timeNowDate.getTime()); // in milliseconds

      _countdowns[elemId] = timeToGo;
      // Set time before countdown
      var countdownRange = _countdownRangeForTime(timeToGo),
          timeTillMinRange = timeToGo - _countdownRangeMin(countdownRange),
          timeBeforeCountdown = timeTillMinRange % countdownRange.interval; // remove intervals that can fit in time till min range

      _updateTimeTillPost(elemId, timeToGo);
      console.log(elemId + ": " + timeToStringDebug(timeToGo) + ", time till countdown: " + timeToStringDebug(timeBeforeCountdown));
      _.delay(_executeCountdown, timeBeforeCountdown, elemId, timeBeforeCountdown, countdownRange);
    });
  };
};