# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "turbolinks:load", ->  
  ###
  Web API of hotwire move to controller since the api key have not access control
  The HTML id and data-destination in Destination dd also remove from view
  if $("#api-container").data("api-url")?
    $.ajax
      method: "GET"
      # use jsonp rather than json to avoid cors error
      dataType: "jsonp"
      url:  $("#api-container").data "api-url"
    .done (data) ->
      container = $("<div></div>").addClass "panel panel-default"
      ul = $("<ul></ul>").addClass "list-group"
      header = $("<div></div>").addClass("panel-heading").text "Suggested hotel"
      container.append header
      container.append ul
      for d, i in data.Result
        headline = "#{d.City} #{d.StarRating.substr 0,1} stars Hotel in #{d.Neighborhood}, #{d.CurrencyCode}#{d.Price}/night" 
        map = $("<img>").addClass("staticmap").attr "src", "https://maps.googleapis.com/maps/api/staticmap?center=#{$("#destination").data("destination")}&size=380x300&scale=2&language=en&key=AIzaSyBkui4rEH4tZbKWeTTacd9E1PyPxw9FXfM&&markers=#{d.NeighborhoodLatitude},#{d.NeighborhoodLongitude}"
        link = $("<a></a>").attr("href", d.Url).attr "target", "_blank"
        li = $("<li></li>").addClass "list-group-item"
        link.append headline
        li.append link
        ul.append li
        ul.append map
      $("#api-container").append container
  ###
  
  # only show the latest 5 comment
  if $("blockquote.user_comment").size() > 5
    $("blockquote.user_comment:nth-child(-n+#{$("blockquote.user_comment").size() - 4})").addClass "hidden"    
    $("#remove_hidden").removeClass("hidden").click ->
      $("blockquote.user_comment.hidden").removeClass "hidden"
      $(@).addClass "hidden"
  
  # reset the comment area after submit new comment success
  $("#new_comment").on "ajax:success", (e, data, status, xhr) ->
    $("#comment_area").val ""
    $("#new_article").append data
    
  