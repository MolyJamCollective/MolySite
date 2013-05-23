var molydeux.home = (function(md, $){
  
  function Home () {
  
    this.init = function() {
      $('#carousel').looper('go');
      jQuery(function($) {
        $('.carousel').on(
          'shown',
          function(e) {
            $('.looper-nav > li', this).removeClass('active').eq(
            e.relatedIndex).addClass('active');
            });
        });
    };
  };
  
  
  md.home = new Home();
  
  $(document).ready(function() {
  
      md.home.init();
  });
  
  return md;

}(molydeux || {}, jQuery));