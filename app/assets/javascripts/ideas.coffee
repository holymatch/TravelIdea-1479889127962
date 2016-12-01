# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "turbolinks:load", ->  
  
  if $("blockquote.user_comment").size() > 5
    $("blockquote.user_comment:nth-child(-n+#{$("blockquote.user_comment").size() - 4})").addClass "hidden"    
    $("#remove_hidden").removeClass("hidden").click ->
      $("blockquote.user_comment.hidden").removeClass "hidden"
      $(@).addClass "hidden"
  
  $("#new_comment").on "ajax:success", (e, data, status, xhr) ->
    $("#comment_area").val ""
    $("#new_article").append data
 
	
  