$(function() {
  $('#lock, #unlock').click(function() {
    var handlerId = $(this).attr("id");
    
    apprise("To " + handlerId + " your time set, we need a password.", {input: true}, function(password) {
      if (password && password !== "") {
        $.post("/" + $('#selector').data('short-url') + "/" + handlerId + ".js", {pass: password});
      }
    });
  });
});