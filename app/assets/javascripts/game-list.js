//////////////////////////////////////////////////////////////////////////////////////////////////
// Grid / List layout toggles 
//////////////////////////////////////////////////////////////////////////////////////////////////

$('#dropdown-grid-button').click(function() {
  $('#game-list-toggle').removeClass('layout-list');
  $('#game-list-toggle').addClass('layout-grid');
  $('#dropdown-grid-button').addClass('active');
  $('#dropdown-grid-button').removeClass('inactive');
  $('#dropdown-list-button').removeClass('active');
  $('#dropdown-list-button').addClass('inactive');
});


$('#dropdown-list-button').click(function() {
  $('#game-list-toggle').addClass('layout-list');
  $('#game-list-toggle').removeClass('layout-grid');
  $('#dropdown-list-button').addClass('active');
  $('#dropdown-list-button').removeClass('inactive');
  $('#dropdown-grid-button').addClass('inactive');
  $('#dropdown-grid-button').removeClass('active');
});

$('.dropdown-platform-link').click(function() {
    var $this = $(this);
    $('#current-platform').html($(this).html());
});


//////////////////////////////////////////////////////////////////////////////////////////////////
// List.js initialization for game list page
//////////////////////////////////////////////////////////////////////////////////////////////////

var gameOptions = {
        valueNames: [ 'name', 'genre', 'location', 'description', 'windows', 'linux', 'mac', 'unity', 'flash', 'html', 'ios', 'android' ] //List out categories here, including searchable ones
    };

var gameList = new List('big-ass-game-list', gameOptions);


//////////////////////////////////////////////////////////////////////////////////////////////////
// List.js filters + filter menu refreshing
//////////////////////////////////////////////////////////////////////////////////////////////////
$('.dropdown-platform-link').click(function(e) {
    var $this = $(this);
    $('#current-platform').html($(this).html());
    var targetId = $(this).attr('id');

    gameList.filter(function(item) {
            if (item.values().windows == targetId) {
                return true;
            } else if (item.values().linux == targetId) {
                return true;
            } else if (item.values().mac == targetId) {
                return true;
            } else if (item.values().unity == targetId) {
                return true;
            } else if (item.values().flash == targetId) {
                return true;
            } else if (item.values().html == targetId) {
                return true;
            } else if (item.values().ios   == targetId) {
                return true;
            } else if (item.values().android == targetId) {
                return true;   
            } else if (targetId == "platform-all") {
                gameList.filter();
                return false;
            } else {
                return false;
            }
        });
        return false;
});

$('.dropdown-genre-link').click(function(e) {
    var $this = $(this);
    $('#current-genre').html($(this).html());
    var targetId = $(this).attr('id');

    gameList.filter(function(item) {
            if (item.values().genre == targetId) {
                return true;
            } else if (targetId == "genre-all") {
                gameList.filter();
                return false;
            } else {
                return false;
            }
        });
        return false;
});

$('.dropdown-location-link').click(function(e) {
    var $this = $(this);
    $('#current-location').html($(this).html());
    var targetId = $(this).attr('id');

    gameList.filter(function(item) {
            if (item.values().location == targetId) {
                return true;
            } else if (targetId == "location-all") {
                gameList.filter();
                return false;
            } else {
                return false;
            }
        });
        return false;
});