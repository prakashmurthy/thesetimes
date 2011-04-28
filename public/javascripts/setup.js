/* setup.js: Polling for sections and loading them onto the page
 * 
 * Turn off text highlighting on the selector
 * Add the existing records to the table
 * bind the destroy click events
*/

$(function() {
  // block of code to remove text highlighting
  var selector = document.getElementById("selector");
  if (typeof selector.onselectstart != "undefined") {
    selector.onselectstart = function() {return false};
  } else if (typeof selector.style.MozUserSelect != "undefined") {
    selector.style.MozUserSelect = "none";
  } else {
    selector.onmousedown = function() {return false};
  }
  selector.style.cursor = "default"
  
  // wrap the selector in jQuery
  var selector = $(selector);
  if (selector.data("new") === "old") {
    // ask the server for all the sections for this timeset
    $.ajax({
      type: "GET",
      url: "/" + selector.data("short-url") + "/sections.js",
      success: function(data) {
        // the data comes back as a string, so we need to parse it first to turn it into objects and arrays
        data = $.parseJSON(data);
        
        // the top level is an array in the JSON, so we iterate through the array
        $.each(data, function(index, section) {
          // store the actual object for the section
          var s = section.section
          
          // find the block where this time started
          var startTimeBlock = s.start.replace(/:\d{2}/, ":00");
          var start = $('#selector tr[data-time="' + startTimeBlock + '"] td[data-day="' + s.day + '"]').first();
          
          // calculate the top offset by adding the starting table cell's offset top to a calculation for minutes based on the table cell's height
          var topOffset = start.offset().top + (/:(\d{2})/.exec(s.start)[1] / 60) * start.height();
          topOffset = Math.round(topOffset);
          
          // left offset is the same as the column's left offset
          var leftOffset = start.offset().left;
          
          // find the block where this time ended
          var endTimeBlock = s.end.replace(/:\d{2}/, ":00");
          var end = $('#selector tr[data-time="' + endTimeBlock + '"] td[data-day="' + s.day + '"]').first();
          
          // make a calculation for height based on the table cell's offset and minutes calculation, subtracting the topOffset we calculated earlier
          var divHeight = end.offset().top + (/:(\d{2})/.exec(s.end)[1] / 60) * end.height() - topOffset;
          divHeight = Math.round(divHeight);
          
          // create the new section to be added to the DOM
          var newSection = $('<div></div>');
          newSection.css({
            height: divHeight + "px",
            top: topOffset + "px",
            left: leftOffset + "px"
          });
          newSection.addClass('section');
          newSection.appendTo("body");
          
          // assign the ID so that we have something to reference for deleting it
          newSection.attr("data-id", s.id);
        });
      }
    });
  }
  
  // binding the destroy events
  $('.section').live('click', function() {
    // check first if the 
    if ($('#selector').attr('data-locked') === "true") return false;
    var clicked = $(this);
    var sectionId = clicked.data('id');
    $.ajax({
      type: "DELETE",
      url: '/sections.js',
      data: {id: sectionId},
      dataType: "script"
    });
  });

});