doBack = (ev) ->
  window.history.back()
  false

backLink = x$ '''<a href="#" class="back">Back</a>'''
backLink.touchstart doBack
backLink.click doBack
x$('header').bottom backLink

