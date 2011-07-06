initBackLink = ->
  backLink = $ '''<a href="#" class="button back">Back</a>'''
  backLink.bind 'touchstart click', doBack
  $('header').append backLink

initAnchors = ->
  if (window.navigator.standalone)
    $('a[data-anchor]').live 'click', (ev) ->
      ev.preventDefault()
      window.location = $(this).attr 'href'
  
doBack = (ev) ->
  window.history.back()
  ev.preventDefault()

init = ->
  initBackLink()
  initAnchors()

$ init
