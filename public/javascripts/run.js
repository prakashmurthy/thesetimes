/* run.js: creating a new section
 * 
 * Bind an event on mousedown to create the new section
 * On the mousedown bind, create the event for mousemove
 * Bind an event on mouseup to finalize the new section and make the request to create
*/


$(function() {  
  
  $('#selector').mousedown(function(e) {
    // if the timeset is locked, we aren't doing anything
    if ($('#selector').attr('data-locked') === "true") return false;
    
    // note where we are starting on the clicked table cell
    var start = $(e.target);
    start.addClass("start");
    
    // calculate the offsets of the starting table cell
    var topOffset = e.pageY;
    leftOffset = start.offset().left;
    
    // create the new section div
    var currentSection = $('<div></div>');
    currentSection.addClass('section').addClass('current');
    currentSection.css({
      top: topOffset + "px",
      left: leftOffset + "px"
    });
    
    // remember which day that this section is landing on
    currentSection.attr("data-day", start.data('day'));
    
    // calculate an amount of minutes starting based on the offest of the mouse click to the top of the clicked table cell
    // Firefox's event object doesn't have an offsetY or offsetX property, so I needed to use pageY
    // --> e.pageY - $(this).offset().top
    var startMinutes = Math.round(((e.pageY - start.offset().top) / start.height()) * 60);
    currentSection.attr("data-start-minutes", startMinutes);
    
    // finally, append this div to the body
    currentSection.appendTo('body');
    
    // this is the event handler that edits the current div when the mouse is being moved up and down
    $('#selector, .current.section').mousemove(function(e) {
      var currentSection = $('.current.section');
      
      // the new height is calculated using the distance to the top of the page of the mouse event minus the element's current offset
      var newHeight = e.pageY - currentSection.offset().top;
      currentSection.css('height', newHeight + "px");
    });
  });
  
  $('#selector').mouseup(function(e) {
    // checking if the time set is locked
    if ($('#selector').attr('data-locked') === "true") return false;
    
    // unbind the mousemove so that we don't edit the height anymore
    $('#selector, .current.section').unbind('mousemove');
    
    var current = $('.current.section');
    
    // get the td that we started with when we used the mousedown event
    var start = $('td.start');
    start.removeClass("start");   // make sure to remove the class so that it is available for the next created section
    var start = start.first();
    
    // store this clicked table cell as the ending cell
    var end = $(e.target);
    
    // Make sure that start is there. If not, we had an issue somewhere.
    if (start.size() === 1) {
      var day = start.data("day");
      
      // calculating the amount of minutes that should be tacked onto the start and end blocks
      var startMinutes = current.data("start-minutes");
      var endMinutes = Math.round(((e.pageY - end.offset().top) / end.height()) * 60);
      
      // stringify the minutes, making sure that it is zero padded
      startMinutes = (startMinutes > 10) ? startMinutes : "0" + startMinutes;
      endMinutes = (endMinutes > 10) ? endMinutes : "0" + endMinutes;
      
      // tack on the minutes to the start and end time blocks
      var startTime = start.data('time').replace("00", startMinutes);
      var endTime = end.data('time').replace("00", endMinutes);
      
      // prepare the data for sending to the server
      var toSend = {
        start_time: startTime,
        end_time: endTime,
        day: day,
        short_url: $('#selector').data('short-url')
      };
      
      // make the request!
      $.post('/sections.js', toSend);
    }
  });
});