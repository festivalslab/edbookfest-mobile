link = null
review = null

toggleReview = (ev) ->
  ev.preventDefault()
  if review.css('display') == 'block'
    hideReview()
  else
    showReview()

hideReview = ->
  review.hide()
  link.text 'Show Amazon review'
  
showReview = ->
  review.show()
  link.text 'Hide Amazon review'

injectLink = ->
  link = $('<a href="#" data-behavior class="button amazon-review-link"></a>')
  link.bind 'click', toggleReview
  review.after link

init = ->
  review = $('.amazon-review')
  return false if !review.length
  injectLink()
  hideReview()

$(document.body).bind 'pageChanged', (ev) ->
  init()