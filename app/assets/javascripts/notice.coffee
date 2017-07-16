ready = ->
  $(".notice").fadeOut(3000)

$(document).ready(ready)
$(document).on('page:load', ready)
$(document).on('page:update', ready)
