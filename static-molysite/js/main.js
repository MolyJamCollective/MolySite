
$('.livestream').click(function() {
  $('.livestream').slideUp('slow', function() {
    $('.video-container').slideDown('slow', function() {
    // Animation complete.
 	 });
  });
});

