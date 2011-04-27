$(function() {  
  /* Create the logger */
  var log = $('#log');
  log.addError = function(str) {
    error = $("<li></li>").text(str);
    error.appendTo(this);
  };
  
  $('td.field').mousedown(function(e) {
    $(this).addClass("start");
    
    // calculate where to put the expanding div
    var topOffset = e.pageY;
    leftOffset = $(this).offset().left;
        
    var currentSection = $('<div></div>');
    currentSection.addClass('section').addClass('current');
    currentSection.css({
      top: topOffset + "px",
      left: leftOffset + "px"
    });
    currentSection.attr("data-day", $(this).data('day'));
    var starttime = Math.round(((e.pageY - $(this).offset().top) / $(this).height()) * 60);
    currentSection.attr("data-start-time", starttime);
    currentSection.appendTo('body');
    
    $('#selector, .current.section').mousemove(function(e) {
      var currentSection = $('.current.section');
      var newHeight = e.pageY - currentSection.offset().top;
      currentSection.css('height', newHeight + "px");
    });
  });
  
  $('td.field').mouseup(function(e) {
    $('#selector, .current.section').unbind('mousemove');
    
    var current = $('.current.section');
        
    var start = $('td.start');
    start.removeClass("start");
    var start = start.first();
    
    var end = $(this);
    
    if (start.size() === 1) {
      var day = start.data("day");

      var startMinutes = current.data("start-time");
      var endMinutes = Math.round(((e.pageY - end.offset().top) / end.height()) * 60);
      
      startMinutes = (startMinutes > 10) ? startMinutes : "0" + startMinutes;
      endMinutes = (endMinutes > 10) ? endMinutes : "0" + endMinutes;
      
      var startTime = start.data('time').replace("00", startMinutes);
      var endTime = end.data('time').replace("00", endMinutes);
      
      var toSend = {
        start_time: startTime,
        end_time: endTime,
        day: day,
        short_url: $('#selector').data('short-url')
      };
      
      $.post('/sections.js', toSend);
    }
  });
});