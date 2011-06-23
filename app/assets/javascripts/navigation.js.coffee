doBack = (ev) ->
  window.history.back()
  false

backLink = x$ '''<a href="#" class="button back arrows">Back</a>'''
backLink.touchstart doBack
backLink.click doBack
x$('header').bottom backLink

