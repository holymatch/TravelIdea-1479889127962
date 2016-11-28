# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$("#new_comment").submit (e) ->
	e.preventDefault
	$.ajax
		type: $(this).attr 'method'
		url: $(this).attr 'action'
		data: $(this).serialize(),
		dataType: "json"
		success: (data) ->
			$("#submit_cmment").button "reset"
			$("#comment_area").val ""
	$("#submit_cmment").button "loading"