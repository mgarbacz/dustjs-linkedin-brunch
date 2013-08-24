dust = require 'dustjs-linkedin'
systemPath = require 'path'

module.exports = class DustCompiler
  brunchPlugin: yes
  type: 'template'
  extension: 'dust'

  constructor: (@config) ->
    null

  compile: (data, path, callback) ->
    try
      # normalize the module name
      if @config.modules?.nameCleaner
        path = @config.modules.nameCleaner(path)

      name = path.replace(/\.dust$/, '')
      console.log("name:", name)
      content = dust.compile(data, name)

      # requiring the module will register this template with dust
      # and export a function that calls dust with the name filled in
      result = """
        #{content}
        if (typeof module !== 'undefined') {
          module.exports = function(context, callback) {
            dust.render(#{JSON.stringify(name)}, context, callback);
          };
        }
      """
    catch err
      error = err
    finally
      callback error, result

  include: ->
    [ (systemPath.join __dirname,
        '..', '..', 'dustjs-linkedin', 'dist', 'dust-core-2.0.2.js') ]
