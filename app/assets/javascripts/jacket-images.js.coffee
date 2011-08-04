alignJacketImages = ->
  $('.amazon-books a').each ->
    image = $ 'img', this
    itemHeight = $(this).height()
    imageHeight = image.height()
    top = (itemHeight - imageHeight) / 2
    image.css 'top', top + 'px'

$(document.body).bind('pageChanged', alignJacketImages)