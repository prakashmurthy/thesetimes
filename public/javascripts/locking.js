/* locking.js: Takes care of locking a time set
 *
 * Binds event handlers to the lock and unlock links
 * Asks for a password and sends it along to the server
*/

$(function() {
  $('#lock, #unlock').live("click", function(e) {
    var handlerId = $(this).attr("id");
    
    // using apprise to ask for a password
    apprise("To " + handlerId + " your time set, we need a password.", {input: true}, function(password) {
      // make sure the password is there and that it's not an empty string before we send it to the server
      if (password && password !== "") {
        // request to lock or unlock the current timeset
        $.post("/" + $('#selector').data('short-url') + "/" + handlerId + ".js", {pass: password});
      }
    });
    
    e.preventDefault();
  });
});