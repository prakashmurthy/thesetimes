$(function() {
  // bind the click handler for collapsing the header
  $("#header-collapse").click(function(e) {
    $('header').slideUp();
    $('footer').hide();
    e.preventDefault();
  })
})