App.youtube_video = App.cable.subscriptions.create "YoutubeVideoChannel",
  connected: ->

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    if $('.content-wrapper').data('company') is data['company']
      $('#youtube-videos').html(data['videos'])
