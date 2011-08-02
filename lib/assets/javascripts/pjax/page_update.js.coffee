loadTimeout = null
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
  
loadTimedOut = ->
  hideLoading()
  
renderLoading = ->
  $('#loading').css({ 'top': window.scrollY }).show()

showLoading = ->
  renderLoading()
  $(window).bind 'scroll', renderLoading
  loadTimeout = window.setTimeout loadTimedOut, timeoutPeriod
  
hideLoading = ->
  window.clearTimeout loadTimeout
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

