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

$(document).bind 'endpjax', ->
  pjaxEl = $ '.pjax-control'
  if pjaxEl.length
    setTheme pjaxEl.data 'theme'
    setTitle pjaxEl.data 'title'
    setSection pjaxEl.data 'section'
    
window.eibf.pageUpdate = {
  setTheme: setTheme
  setTitle: setTitle
  setSection: setSection
}

