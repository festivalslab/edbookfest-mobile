beforeEach(function() {
  this.fixture = function(html) {
    var fixture = $(html),
      sandbox = $('<div id="sandbox"></div>');
      sandbox.append(fixture);
      $(document.body).append(sandbox);
  };
});

afterEach(function() {
  $('#sandbox').remove();
});