/*
 * Location Sorting
 */
var options = {
  valueNames: ['name', 'description', 'category', 'country']
};

var featureList = new List('locations-list', options);

/*
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
}); */

var molydeux = molydeux || {};

molydeux.location = (function($) {

  var that;

    return {

      init: function() {

        that = molydeux.location;

        $('.btn.filter')
          .click(this.filterList);

          that.updateListMap();

      },

      updateListMap: function() {

        console.log($('#locations-list'));

        if ($('#locations-list').length == 0)
        {
          console.log('no location list found');
          return false;
        }
        var locations = new Array();

        console.log("Locations: "+$('#locations-list .list li').length);

        $('#locations-list .list li')
          .each(function(index, element) {

          locations.push({
            address: $(element)
              .find('.address')
              .first()
              .text(),
            data: $(element)
              .find('.name')
              .first()
              .text()
          });

        });

        $('.map').gmap3('destroy').gmap3({
          map: {
            options: {
              maxZoom: 14
            }
          },

          marker: {
            values: locations,
            options: {
              icon: this.icon
            }
          }
        }, "autofit");

      },

      makeIcon: function(imagePath, width, height) {
        var myIcon = null;

        myIcon = new google.maps.MarkerImage(imagePath,
        new google.maps.Size(width, height, "px", "px"));

        return myIcon;

      },

      filterList: function(event) {

        var target = event.target;

        var category = 'none';

        event.preventDefault();

        if (!$(target)
          .hasClass('filter')) {

          target = $(target)
            .parents('filter')
            .first();

        }

        category = $(target)
          .attr('data-category');

        console.log('filter: ' + category);

        featureList.filter(function(item) {
          if (category == 'none') return true;

          if ((item.values()
            .category == category)) {
            return true;
          } else {
            return false;
          }
        });

        that.updateListMap();

      }

    };

})(jQuery);

$(document).ready(function() {
  molydeux.location.init();
});
