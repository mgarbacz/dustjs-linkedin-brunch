var Dust = require('dustjs-linkedin');

describe('Plugin', function() {
  var plugin;

  beforeEach(function() {
    plugin = new Plugin({});
  });

  it('should be an object', function() {
    expect(plugin).to.be.ok;
  });

  it('should has #compile method', function() {
    expect(plugin.compile).to.be.an.instanceof(Function);
  });

  it('should compile and produce valid result', function(done) {
    var content = '<h1>Hello {{name}}!</h1>';
    var expected = '<h1>Hello Batman!</h1>';

    plugin.compile(content, 'template.dust', function(error, data) {
      var compiled = eval(data)
      dust.loadSource(compiled);
      dust.render('template', { 'name': 'Batman' }. function(error, output) {
        expect(error).not.to.be.ok;
        expect(ouput).to.equal(expected);
        done();
      });
    });
  });
});
