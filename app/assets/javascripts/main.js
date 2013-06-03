
$('.livestream').click(function() {
  $('.livestream').slideUp('slow', function() {
    $('.video-container').slideDown('slow', function() {
    // Animation complete.
 	 });
  });
});


jQuery(function($){
            $(".tweet").tweet({
                username: ["holdenlink","angusp", "sirW0lfgang"],
                join_text: "auto",
                avatar_size: 50,
                count: 5,
                loading_text: "loading tweets...",
                template: "{avatar}{screen_name} » {text}"
            });
         });


  

function getName(){


  FB.getLoginStatus(function(response) {
  if (response.status === 'connected') {
    // the user is logged in and has authenticated your
    // app, and response.authResponse supplies
    // the user's ID, a valid access token, a signed
    // request, and the time the access token 
    // and signed request each expire
    var uid = response.authResponse.userID;
    var accessToken = response.authResponse.accessToken;
    FB.api('321794224546563?fields=attending', function(response) {
        
        var result = 0;
        var obj = response.attending.data;
        for(var prop in obj) {
        if (obj.hasOwnProperty(prop)) {
          // or Object.prototype.hasOwnProperty.call(obj, prop)
          result++;
        }
      }
      $('#fb-attendees').html(result);
      });

      
      }
       else if (response.status === 'not_authorized') {
        // the user is logged in to Facebook, 
        // but has not authenticated your app
      } else {
        // the user isn't logged in to Facebook.
      }
    

  });
}


 