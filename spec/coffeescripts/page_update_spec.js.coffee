describe "PJAX page_update", ->
  describe "#setTheme", ->
    beforeEach ->
      this.body = $ document.body
    
    afterEach ->
      $(document.body).removeClass "events books authors"
    
    describe "when no theme is set", ->      
      it "sets the provided theme", ->
        eibf.pageUpdate.setTheme "authors"
        expect(this.body).toHaveClass "authors"
        
    describe "when a different theme is already set", ->
      beforeEach ->
        this.body.addClass "events"
      
      it "removes the current theme", ->
        eibf.pageUpdate.setTheme "authors"
        expect(this.body).not.toHaveClass "events"
        
      it "set the new theme", ->
        eibf.pageUpdate.setTheme "authors"
        expect(this.body).toHaveClass "authors"
        
    describe "when same theme is already set", ->
      beforeEach ->
        this.body.addClass "authors"
      
      it "keeps the current theme", ->
        eibf.pageUpdate.setTheme "authors"
        expect(this.body).toHaveClass "authors"
        
      it "does not duplicate the class", ->
        eibf.pageUpdate.setTheme "authors"
        expect(this.body.attr('class').split(" ").length).toEqual 1
          
  describe "#setTitle", ->
    describe "when current title is empty except for prefix", ->
      beforeEach ->
        document.title = 'EdBookFest'
        
      it "adds the new title to the end", ->
        eibf.pageUpdate.setTitle "My Title"
        expect(document.title).toEqual "EdBookFest – My Title"
      
      it "does nothing with an empty title", ->
        eibf.pageUpdate.setTitle ""
        expect(document.title).toEqual "EdBookFest"
    
    describe "when current title is populated", ->
      beforeEach ->
        document.title = 'EdBookFest – Existing Title'
        
      it "removes the title and divider if an empty title is provided", ->
        eibf.pageUpdate.setTitle ""
        expect(document.title).toEqual "EdBookFest"
        
      it "replaces the title if title is provided", ->
        eibf.pageUpdate.setTitle "New Title"
        expect(document.title).toEqual "EdBookFest – New Title"
        
      it "replaces the title if title is provided with an additional em dash", ->
        eibf.pageUpdate.setTitle "New Title – With Dash"
        expect(document.title).toEqual "EdBookFest – New Title – With Dash"
        
    describe "when current title is populated with additional em dash", ->
      beforeEach ->
        document.title = "EdBookFest – Existing Title – With Dash"
      
      it "removes the title and divider if an empty title is provided", ->
        eibf.pageUpdate.setTitle ""
        expect(document.title).toEqual "EdBookFest"

      it "replaces the title if title is provided", ->
        eibf.pageUpdate.setTitle "New Title"
        expect(document.title).toEqual "EdBookFest – New Title"

      it "replaces the title if title is provided with an additional em dash", ->
        eibf.pageUpdate.setTitle "New Title – With Dash"
        expect(document.title).toEqual "EdBookFest – New Title – With Dash"
        
  describe "#setSection", ->
    describe "when current section is empty", ->
      beforeEach ->
        this.fixture '<div id="container"><header><h2></h2></header></div>'
      
      it "adds the new section title", ->
        eibf.pageUpdate.setSection "Events"
        expect($('#container h2')).toHaveText "Events"
        
    describe "when current section is populated", ->
      beforeEach ->
        this.fixture '<div id="container"><header><h2>Authors</h2></header></div>'
      
      it "adds the new section title", ->
        eibf.pageUpdate.setSection "Events"
        expect($('#container h2')).toHaveText "Events"
    

        