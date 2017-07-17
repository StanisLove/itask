ready = ->
  $(".new-task-link").click (e) ->
    e.preventDefault()
    $("#task-form").toggle()
    $(".new-task-link").toggle()
    $(".away-task-form").toggle()

  $(".away-task-form").click (e) ->
    e.preventDefault()
    $("#task-form").toggle()
    $(".new-task-link").toggle()
    $(".away-task-form").toggle()

  $(".upload").click (e) ->
    e.currentTarget.parentElement.getElementsByClassName('upload-input')[0].click()


$(document).ready(ready)
$(document).on('page:load', ready)
$(document).on('page:update', ready)

