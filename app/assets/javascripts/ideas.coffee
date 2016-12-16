# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "turbolinks:load", ->  

  dateFormat = 'yy-mm-dd'

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
      return
	  
  # handle error on ajax success
  $("#new_idea,#new_comment").on("ajax:error", (e, xhr, status, error) ->
    error_msg = xhr.responseJSON
    model = $(@).data "model"
    header = $("<h4></h4>").text("#{pluralize 'error', Object.keys(error_msg).length, true} prohibited this #{model} from being saved:") 
    ul = $("<ul></ul>")
    $("#error_explanation").empty().append(header).removeClass("hidden").append ul
    # clear all old error
    $(".field_with_errors").removeClass "field_with_errors"
    Object.keys(error_msg).forEach (key) ->
      li = $("<li></li>").text ("#{key.capitalizeFirstLetter()} #{error_msg[key][0]}")
      $("##{model}_#{key}").parent().addClass "field_with_errors"
      ul.append li 
      return
    return
    ).on "ajax:success", (e, data, status, xhr) ->
      # clear all error after success
      $("#error_explanation").empty().addClass "hidden"
      $(".field_with_errors").removeClass "field_with_errors"
      return
  
  # reset the comment area after submit new comment success
  $("#new_comment").on "ajax:success", (e, data, status, xhr) ->
    $("#comment_content").val ""
    $("#new_article").append data
    return
  
  getDate = (element) ->
    try
      date = $.datepicker.parseDate( dateFormat, $(element).val());
    catch error
      date = null
    date  
  
  $("#idea_start_date").datepicker
    dateFormat: dateFormat
    minDate: new Date()
  .change ->
    $("#idea_end_date").datepicker "option", "minDate", getDate @
    $("#idea_end_date").val($(@).val()) unless $("#idea_end_date").val() != ""
    return
  
  $("#idea_end_date").datepicker
    dateFormat: dateFormat
    minDate: getDate $("#idea_start_date")
  
  update_tags = ->
    $("#idea_tags").val(tags.getTagValues().join())
  
  if $("#tags").length > 0
    tags = new Taggle 'tags',
      duplicateTagClass: 'bounce'
      #additionalTagClasses: 'bg-primary'
      saveOnBlur: true
      placeholder: "Tags"
      preserveCase: true
      tags: if $("#idea_tags").val() != "" then $("#idea_tags").val().split(',') else []
      onTagAdd: (event, data) ->
        update_tags()
        return
      onTagRemove: (event, data) ->
        update_tags()
        return
  
  return
    
  