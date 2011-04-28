/* snapping.js: Enable snapping to 15 minute intervals
 *
 * Bind the event handler to the snapping ancher to enable/disable snapping
*/

$(function() {
  $('#snapping').click(function(e) {
    var handler = $(this);
    var state = handler.attr("data-snap");
    
    if (state === "false") {
      handler.attr("data-snap", "true");
      handler.text("Disable Snapping");
    } else {
      handler.attr("data-snap", "false");
      handler.text("Enable Snapping");
    }
    
    e.preventDefault();
  });
});