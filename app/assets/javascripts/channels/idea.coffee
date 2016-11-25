App.idea = App.cable.subscriptions.create { channel: "IdeaChannel", idea_id: 1},
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    console.log(data)
    @appendComment(data)
		
  appendComment: (data) ->
    $('#comment_list').append data
