doBack = (ev) ->
  window.history.back()
  ev.preventDefault()

init = ->
  backLink = $ '''<a href="#" class="button back">Back</a>'''
  backLink.bind 'touchstart click', doBack
  $('header').append backLink

$ init
