$(document).ready ->
  $(document.body).trigger 'pageChanged'
  $(document.body).trigger 'pageUpdated'

$(document).bind 'endpjax', ->
  $(document).trigger 'pageChanged'
  $(document).trigger 'pageUpdated'

$(document).bind 'ajaxComplete', ->
  $(document.body).trigger 'pageUpdated'
