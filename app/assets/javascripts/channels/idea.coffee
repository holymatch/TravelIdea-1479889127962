$ ->
  if $("#comment_idea_id").val()?
    App.idea = App.cable.subscriptions.create { channel: "IdeaChannel", idea_id: $("#comment_idea_id").val()},
      connected: ->
        # Called when the subscription is ready for use on the server
    
      disconnected: ->
        # Called when the subscription has been terminated by the server
    
      received: (data) ->
        $('#comment_list').append data
  else if App.idea? && !App.cable.connection.disconnected
    App.idea.unsubscribe
    #App.cable.disconnect
