App.youtube_video = App.cable.subscriptions.create "YoutubeVideoChannel",
  connected: ->
    alert("Connected!")
  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    alert("Received!")
    # Called when there's incoming data on the websocket for this channel
