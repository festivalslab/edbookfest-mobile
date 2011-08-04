handleOutboundLink = (ev) ->
  category = "Outbound Links"
  link = $(this).attr('href')
  action = $(this).data 'analytics-action'
  _gaq.push(['_trackEvent', category, action, link]);

init = ->
  $('[data-remote]').live 'click', handleOutboundLink

$ init