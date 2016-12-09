// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require datatables
//= require turbolinks
//= require bootstrap-sprockets
//= require_tree .


$(document).on( "turbolinks:load", function() {
  if ($("#api-container").data("api-url") != null)
  {
	  $.ajax({
		  method: "GET",
		  dataType: 'jsonp',
		  //jsonp: "callback",
		  url: $("#api-container").data("api-url")
		})
		  .done(function( data ) {
			console.log(data );
			var container = $("<div></div>").addClass("panel panel-default");
			var ul = $("<ul></ul>").addClass("list-group");
			var header = $("<div></div>").addClass("panel-heading").text("Suggested hotel");
			container.append(header);
			container.append(ul);
			data.Result.forEach(function(d, i) {
				var headline = d.City + " " + d.StarRating.substring(0,1) + " stars Hotel in " + d.Neighborhood + ", " + d.CurrencyCode + d.Price + " /night" 
				var map = $("<img>").addClass("staticmap").attr("src", "https://maps.googleapis.com/maps/api/staticmap?center=" + $("#destination").data("destination") + "&size=380x300&scale=2&language=en&key=AIzaSyBkui4rEH4tZbKWeTTacd9E1PyPxw9FXfM&&markers=" + d.NeighborhoodLatitude + "," + d.NeighborhoodLongitude);
				var link = $("<a></a>").attr("href", d.Url).attr("target", "_blank");
				var li = $("<li></li>").addClass("list-group-item");
				link.append(headline);
				li.append(link);
				ul.append(li);
				ul.append(map);
				
			});
			$("#api-container").append(container);
		  });
  }
});