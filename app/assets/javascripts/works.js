$(function() {

  $(document.documentElement).keydown(function(e) {
    if(e.which == 37 || e.which == 39) {
      e.preventDefault();
      if (e.which == 37) // left
        link = $('#prev_work');
      else
        link = $('#next_work');
      if (link.length == 1) {
        window.location = link.attr('href');
      }
    }
  });
  
});
