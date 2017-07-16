ready = ->
  $("#login-link").click (e) ->
    e.preventDefault()
    $("#login-form").toggle('slow')
    $("#signup-form").toggle()

  $("#signup-link").click (e) ->
    e.preventDefault()
    $("#signup-form").toggle('slow')
    $("#login-form").toggle()

$(document).ready(ready)
$(document).on('page:load', ready)
$(document).on('page:update', ready)
