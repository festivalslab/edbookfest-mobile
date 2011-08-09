loadTimeout = null
scrollInterval = null
scrollIntervalTime = 100
timeoutPeriod = 20000

themes = [
  "events"
  "books"
  "authors"
]

setTheme = (theme) ->
  body = $ document.body
  if !body.hasClass theme
    body.removeClass themes.join " "
    body.addClass theme
    
setTitle = (title) ->
  mainTitle = document.title.split('–')[0].trim()
  subTitle = if title then "– #{title}" else ""
  document.title = "#{mainTitle} #{subTitle}"

setSection = (section) ->
  $('#container header h2').text section
  
scrollTop = ->
  window.scrollTo 0, 0
  
positionLoader = ->
  $('#loading span').css({ 'top': window.scrollY + window.innerHeight/2 - 12 + 'px' })

renderLoading = ->
  positionLoader()
  $('#loading').css({ 'height': document.height + 'px' }).show()

showLoading = ->
  renderLoading()
  scrollInterval = window.setInterval positionLoader, scrollIntervalTime
  loadTimeout = window.setTimeout hideLoading, timeoutPeriod
  
hideLoading = ->
  window.clearTimeout loadTimeout
  window.clearInterval scrollInterval
  $(window).unbind 'scroll', renderLoading
  $('#loading').hide()
  
$(document).bind('startpjax', showLoading)
  .bind('endpjax', (ev) ->
    hideLoading()
    pjaxEl = $ '.pjax-control'
    if pjaxEl.length
      setTheme pjaxEl.data 'theme'
      setTitle pjaxEl.data 'title'
      setSection pjaxEl.data 'section'
      scrollTop()
  )
    
window.eibf.pageUpdate = {
  setTheme: setTheme
  setTitle: setTitle
  setSection: setSection
}

