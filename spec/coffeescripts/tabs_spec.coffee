describe "tabs", ->
  
  beforeEach ->
    this.fixture fixtures.tabs
    $('#container').tabs 'section', 'h3'
  
  describe "initial state", ->
    
    it "creates a nav list item for each section", ->
      expect($('#container ul.tabs li').length).toEqual 3
      $('#container ul.tabs li').each (i) ->
        expect($(this).text()).toEqual "Title #{i+1}"
    
    it "hides the original titles", ->
      $('#container h3').each ->
        expect($(this).css('display')).toEqual 'none'
    
    it "displays the first section and hides the others", ->
      expect($('#container section').first().css('display')).toEqual 'block' 
      expect($('#container section').first().next().css('display')).toEqual 'none' 
      expect($('#container section').last().css('display')).toEqual 'none'
      
    it "highlights the first tab and not the others", ->
      expect($('ul.tabs li').first()).toHaveClass 'active'
      expect($('ul.tabs li').first().next()).not.toHaveClass 'active'
      expect($('ul.tabs li').last()).not.toHaveClass 'active'
      
  describe "when clicking on a nav link", ->
    
    beforeEach ->
      $('#container ul.tabs li').first().next().trigger 'click'
    
    it "shows the section corresponding to the clicked item", ->
      expect($('#container section').first().css('display')).toEqual 'none' 
      expect($('#container section').first().next().css('display')).toEqual 'block' 
      expect($('#container section').last().css('display')).toEqual 'none'
      
    it "highlights the corresponding tab and not the others", ->
      expect($('ul.tabs li').first()).not.toHaveClass 'active'
      expect($('ul.tabs li').first().next()).toHaveClass 'active'
      expect($('ul.tabs li').last()).not.toHaveClass 'active'
