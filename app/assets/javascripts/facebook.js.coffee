jQuery ->
  $('body').prepend('<div id="fb-root"></div>')

  $.ajax
    url: "#{window.location.protocol}//connect.facebook.net/en_US/all.js"
    dataType: 'script'
    cache: true

window.fbAsyncInit = ->
  FB.init(appId: '2016329431980256', cookie: true, oauth: true)

  $('#facebook-popup').click (e) ->
    e.preventDefault()
    FB.login ((response) ->
      window.location = 'auth/facebook/callback' if response.authResponse
    ), scope: 'email'