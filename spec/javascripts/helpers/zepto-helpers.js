beforeEach(function() {
  this.addMatchers({
    toHaveClass: function(expected) {
      return this.actual.hasClass(expected);
    }
  })
});