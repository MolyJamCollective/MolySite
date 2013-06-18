
var screenwidth = $('#splash').css('width');
var cubewidth = $('.cube').css('width');

screenwidth = parseInt(screenwidth);
cubewidth = parseInt(cubewidth);

var cubePos = $('.cube').css('left');



$("#splash").bind('mousemove', function(e) {
	var cubePos = parseInt($('.cube').css('left'));
	
	if (e.pageX < ((screenwidth / 2))){
		$(".cube").css({
        left:  (-1*0.1*((screenwidth/2)-e.pageX)) + 'px '

   		 });
	}
	else{

		$(".cube").css({
        left: (0.1*(e.pageX-(screenwidth/2))) +  'px '

   		 });
	}
    
});