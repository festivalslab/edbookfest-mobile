(($) ->
  
  $.extend $.fn, 
    tabs: (groupSelector, titleSelector) ->
      container = $ this
      sections = $(groupSelector, this)
      tabList = $('<ul/>').addClass 'tabs'
      
      switchTab = (ev) ->
        target = $(ev.target)
        index = target.parent().children().index target
        sections.hide()
        $(sections.get(index)).show()
        tabList.find('li').removeClass 'active'
        $(tabList.find('li').get(index)).addClass 'active'
      
      sections.add(titleSelector).hide()
      sections.first().show()
      sections.each (i, grp) ->
        title = $(titleSelector, grp).text()
        tabItem = $('<li/>').text(title).bind 'click', switchTab
        tabList.append tabItem
        tabItem.addClass('active') if i == 0
      this.prepend tabList
      
) window.Zepto

$(document).ready ->
  $('.tabs-container').tabs '.tab-content', '.tab-title'
  
