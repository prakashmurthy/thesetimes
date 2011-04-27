$(function() {
  // remove the ability to highlight text on the selector table
  var selector = document.getElementById("selector");
  if (typeof selector.onselectstart != "undefined") {
    selector.onselectstart = function() {return false};
  } else if (typeof selector.style.MozUserSelect != "undefined") {
    selector.style.MozUserSelect = "none";
  } else {
    selector.onmousedown = function() {return false};
  }

  selector.style.cursor = "default"
  
  // if this isn't a new record, then we need to fetch the sections
  var selector = $(selector);
  if (selector.data("new") === "old") {
    $.ajax({
      type: "GET",
      url: "/" + selector.data("short-url") + "/sections.js",
      success: function(data) {
        data = $.parseJSON(data);
        $.each(data, function(index, section) {
          var s = section.section

          var startTimeBlock = s.start.replace(/:\d{2}/, ":00");
          var start = $('#selector tr[data-time="' + startTimeBlock + '"] td[data-day="' + s.day + '"]').first();
          
          var topOffset = start.offset().top + (/:(\d{2})/.exec(s.start)[1] / 60) * start.height();
          topOffset = Math.round(topOffset);
          
          var leftOffset = start.offset().left;
          
          var endTimeBlock = s.end.replace(/:\d{2}/, ":00");
          var end = $('#selector tr[data-time="' + endTimeBlock + '"] td[data-day="' + s.day + '"]').first();
          
          var divHeight = end.offset().top + (/:(\d{2})/.exec(s.end)[1] / 60) * end.height() - topOffset;
          divHeight = Math.round(divHeight);
          
          var newSection = $('<div></div>');
          newSection.css({
            height: divHeight + "px",
            top: topOffset + "px",
            left: leftOffset + "px"
          });
          newSection.addClass('section');
          newSection.appendTo("body");
          newSection.attr("data-id", s.id);
        });
      }
    });
  }
  
  $('.section').live('click', function() {
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