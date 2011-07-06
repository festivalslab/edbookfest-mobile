(function() {
  describe("tabs", function() {
    beforeEach(function() {
      this.fixture(fixtures.tabs);
      return $('#container').tabs('section', 'h3');
    });
    describe("initial state", function() {
      it("creates a nav list item for each section", function() {
        expect($('#container ul.tabs li').length).toEqual(3);
        return $('#container ul.tabs li').each(function(i) {
          return expect($(this).text()).toEqual("Title " + (i + 1));
        });
      });
      it("hides the original titles", function() {
        return $('#container h3').each(function() {
          return expect($(this).css('display')).toEqual('none');
        });
      });
      it("displays the first section and hides the others", function() {
        expect($('#container section').first().css('display')).toEqual('block');
        expect($('#container section').first().next().css('display')).toEqual('none');
        return expect($('#container section').last().css('display')).toEqual('none');
      });
      return it("highlights the first tab and not the others", function() {
        expect($('ul.tabs li').first()).toHaveClass('active');
        expect($('ul.tabs li').first().next()).not.toHaveClass('active');
        return expect($('ul.tabs li').last()).not.toHaveClass('active');
      });
    });
    return describe("when clicking on a nav link", function() {
      beforeEach(function() {
        return $('#container ul.tabs li').first().next().trigger('click');
      });
      it("shows the section corresponding to the clicked item", function() {
        expect($('#container section').first().css('display')).toEqual('none');
        expect($('#container section').first().next().css('display')).toEqual('block');
        return expect($('#container section').last().css('display')).toEqual('none');
      });
      return it("highlights the corresponding tab and not the others", function() {
        expect($('ul.tabs li').first()).not.toHaveClass('active');
        expect($('ul.tabs li').first().next()).toHaveClass('active');
        return expect($('ul.tabs li').last()).not.toHaveClass('active');
      });
    });
  });
}).call(this);
