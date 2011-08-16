$ ->
  setEventImageSize = ->
    ratio = .767
    eventImage = $ 'img.event'
    eventImage.css('height', Math.round(eventImage.width() * ratio) + 'px')
  
  $(document.body).bind('pageChanged', setEventImageSize)
  $(window).bind('resize', setEventImageSize)
  