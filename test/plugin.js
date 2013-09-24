var dust = require('dustjs-linkedin');

var config = {
  modules: {
    nameCleaner: function(path) {
      return path.replace(/^.*\//, ''); // remove all leading directories
    }
  }
};

describe('Plugin', function() {
  var plugin;

  beforeEach(function() {
    plugin = new Plugin(config);
  });

  it('should be an object', function() {
    expect(plugin).to.be.ok;
  });

  it('should has #compile method', function() {
    expect(plugin.compile).to.be.an.instanceof(Function);
  });

  it('should include dustjs-core', function() {
    var expected = 'node_modules/dustjs-linkedin/dist/dust-core-';
    expect(plugin.include()).to.contain(expected);
  });

  it('should include correct version of dustjs-core', function() {
    var expected =
      new RegExp('((?:[a-z][a-z]+))(-)(\\d+)(\\.)(\\d+)(\\.)(\\d+)(\\.)(js)');
    expect(plugin.include()).to.match(expected);
  });

  it('should compile and produce valid result', function(done) {
    var content = '<h1>Hello {name}!</h1>';
    var expected = '<h1>Hello Batman!</h1>';

    plugin.compile(content, 'dirs/dir/template.dust', function(error, data) {
      expect(error).not.to.be.ok;

      dust.loadSource(data);
      dust.render('template', {'name': 'Batman'}, function(error, output) {
        expect(error).not.to.be.ok;
        expect(output).to.equal(expected);
        done();
      });
    });
  });
});
