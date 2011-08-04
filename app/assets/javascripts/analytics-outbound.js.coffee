handleOutboundLink = (ev) ->
  ev.preventDefault()
  category = "Outbound Links"
  link = $(this).attr('href')
  action = $(this).data 'analytics-action'
  _gaq.push(['_trackEvent', category, action, link]);
  window.setTimeout (-> window.location = link), 100 

init = ->
  $('[data-remote]').live 'click', handleOutboundLink

$ init