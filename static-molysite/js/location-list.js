

    /*
    * Location Sorting
    */

    var options = {
	    valueNames: [ 'name', 'description', 'category', 'country' ]
    };

    var featureList = new List('locations-list', options);

    $('#filter-northamerica').click(function() {
        featureList.filter(function(item) {
            if (item.values().category == "northamerica") {
                return true;
            } else {
                return false;
            }
        });
        return false;
    });

    $('#filter-europe').click(function() {
        featureList.filter(function(item) {
            if (item.values().category == "europe") {
                return true;
            } else {
                return false;
            }
        });
        return false;
    });

     $('#filter-australia').click(function() {
        featureList.filter(function(item) {
            if (item.values().category == "australia") {
                return true;
            } else {
                return false;
            }
        });
        return false;
    });

      $('#filter-southamerica').click(function() {
        featureList.filter(function(item) {
            if (item.values().category == "southamerica") {
                return true;
            } else {
                return false;
            }
        });
        return false;
    });

       $('#filter-asia').click(function() {
        featureList.filter(function(item) {
            if (item.values().category == "asia") {
                return true;
            } else {
                return false;
            }
        });
        return false;
    });
    $('#filter-none').click(function() {
        featureList.filter();
        return false;
    });

var molydeux = (function(md, $) {
  
  function Location () {
    
    this.init = function() {
      
      $('.map').gmap3({
        map: {
          options: {
                maxZoom: 14
            }
        },
        
        marker: {
            values:[
              {address:"San Francisco, US", data:"San Francisco, US"}
            ],
            options: {
                icon: this.icon
            }
        }
      }, "autofit");

      
    };
    
    this.makeIcon = function(imagePath, width, height) {
      var myIcon = null;
      
      myIcon = new google.maps.MarkerImage(imagePath, 
        new google.maps.Size(width, height, "px", "px")
      );
      
      return myIcon;
      
    };
    
  
  };
  
  md.location = new Location();
  
  $(document).ready(function() {
    md.location.init();
  });
  
  return md;
  
}(molydeux || {}, jQuery));

