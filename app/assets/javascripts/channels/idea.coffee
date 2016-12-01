# use turbolinks:load replace document ready for using turbolinks
$(document).on "turbolinks:load", ->
  # call when page change by turbolinks
  $(document).on "turbolinks:before-visit", ->
    if App.cable.subscriptions['subscriptions'].length > 0 && App.idea?
      App.idea.unsubscribe()
  
  subscription_channel = ->
    if $("#comment_idea_id").val()?
      App.idea = App.cable.subscriptions.create { channel: "IdeaChannel", idea_id: $("#comment_idea_id").val()},
        connected: ->
          # Called when the subscription is ready for use on the server
      
        disconnected: ->
          # Called when the subscription has been terminated by the server
          # resubscription the channel when the server disconnect unexcepted
          subscription_channel()
      
        received: (data) ->
          $('#comment_list').append data
          
  subscription_channel()