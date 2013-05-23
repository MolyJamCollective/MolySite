// /////////////////////////////////////////////////////////////////////////////////////////////
//
// Fading Navbar BG code stolen liberally from Stack Overflow:
// http://stackoverflow.com/questions/8702329/jquery-javascript-opacity-animation-with-scroll
//
// /////////////////////////////////////////////////////////////////////////////////////////////

var fadeStart = 100, // 100px scroll or less will equiv to 0 opacity
    fadeUntil = 250, // 250px scroll or more will equiv to 1 opacity
    fading = $('.navbar-background');

$(window).bind('scroll', function() {

  fading.css('height', $('.navbar-inner').css('height')); // set the
  // background cell
  // to the height of
  // the actual cell

  var offset = $(document).scrollTop(), opacity = 0.8;
  if (offset <= fadeStart) {
    opacity = 0;

  } else if (offset <= fadeUntil) {
    opacity = 0 + offset / fadeUntil;

  }
  fading.css('opacity', opacity);
});