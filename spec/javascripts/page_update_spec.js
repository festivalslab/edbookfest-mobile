(function() {
  describe("PJAX page_update", function() {
    describe("#setTheme", function() {
      beforeEach(function() {
        return this.body = $(document.body);
      });
      afterEach(function() {
        return $(document.body).removeClass("events books authors");
      });
      describe("when no theme is set", function() {
        return it("sets the provided theme", function() {
          eibf.pageUpdate.setTheme("authors");
          return expect(this.body).toHaveClass("authors");
        });
      });
      describe("when a different theme is already set", function() {
        beforeEach(function() {
          return this.body.addClass("events");
        });
        it("removes the current theme", function() {
          eibf.pageUpdate.setTheme("authors");
          return expect(this.body).not.toHaveClass("events");
        });
        return it("set the new theme", function() {
          eibf.pageUpdate.setTheme("authors");
          return expect(this.body).toHaveClass("authors");
        });
      });
      return describe("when same theme is already set", function() {
        beforeEach(function() {
          return this.body.addClass("authors");
        });
        it("keeps the current theme", function() {
          eibf.pageUpdate.setTheme("authors");
          return expect(this.body).toHaveClass("authors");
        });
        return it("does not duplicate the class", function() {
          eibf.pageUpdate.setTheme("authors");
          return expect(this.body.attr('class').split(" ").length).toEqual(1);
        });
      });
    });
    describe("#setTitle", function() {
      describe("when current title is empty except for prefix", function() {
        beforeEach(function() {
          return document.title = 'EdBookFest';
        });
        it("adds the new title to the end", function() {
          eibf.pageUpdate.setTitle("My Title");
          return expect(document.title).toEqual("EdBookFest – My Title");
        });
        return it("does nothing with an empty title", function() {
          eibf.pageUpdate.setTitle("");
          return expect(document.title).toEqual("EdBookFest");
        });
      });
      describe("when current title is populated", function() {
        beforeEach(function() {
          return document.title = 'EdBookFest – Existing Title';
        });
        it("removes the title and divider if an empty title is provided", function() {
          eibf.pageUpdate.setTitle("");
          return expect(document.title).toEqual("EdBookFest");
        });
        it("replaces the title if title is provided", function() {
          eibf.pageUpdate.setTitle("New Title");
          return expect(document.title).toEqual("EdBookFest – New Title");
        });
        return it("replaces the title if title is provided with an additional em dash", function() {
          eibf.pageUpdate.setTitle("New Title – With Dash");
          return expect(document.title).toEqual("EdBookFest – New Title – With Dash");
        });
      });
      return describe("when current title is populated with additional em dash", function() {
        beforeEach(function() {
          return document.title = "EdBookFest – Existing Title – With Dash";
        });
        it("removes the title and divider if an empty title is provided", function() {
          eibf.pageUpdate.setTitle("");
          return expect(document.title).toEqual("EdBookFest");
        });
        it("replaces the title if title is provided", function() {
          eibf.pageUpdate.setTitle("New Title");
          return expect(document.title).toEqual("EdBookFest – New Title");
        });
        return it("replaces the title if title is provided with an additional em dash", function() {
          eibf.pageUpdate.setTitle("New Title – With Dash");
          return expect(document.title).toEqual("EdBookFest – New Title – With Dash");
        });
      });
    });
    return describe("#setSection", function() {
      describe("when current section is empty", function() {
        beforeEach(function() {
          return this.fixture('<div id="container"><header><h2></h2></header></div>');
        });
        return it("adds the new section title", function() {
          eibf.pageUpdate.setSection("Events");
          return expect($('#container h2')).toHaveText("Events");
        });
      });
      return describe("when current section is populated", function() {
        beforeEach(function() {
          return this.fixture('<div id="container"><header><h2>Authors</h2></header></div>');
        });
        return it("adds the new section title", function() {
          eibf.pageUpdate.setSection("Events");
          return expect($('#container h2')).toHaveText("Events");
        });
      });
    });
  });
}).call(this);
