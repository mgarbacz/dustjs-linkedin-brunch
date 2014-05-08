dust = require 'dustjs-linkedin'
systemPath = require 'path'

module.exports = class DustCompiler
  brunchPlugin: yes
  type: 'template'
  extension: 'dust'

  constructor: (@config) ->
    if @config.plugins?.dust?.retainWhitespace
      dust.optimizers.format = (ctx, node)->node

  compile: (data, path, callback) ->
    try
      # normalize the module name
      if @config.modules?.nameCleaner
        path = @config.modules.nameCleaner(path)

      name = path.replace(/\.dust$/, '')
      content = dust.compile(data, name)

      # requiring the module will register this template with dust
      # and export the block function with "render" and "stream" helpers
      result = """
        var tmpl = #{content}
        module.exports = tmpl;
        module.exports.render = function(context, callback) {
          dust.render(#{JSON.stringify(name)}, context, callback);
        };
        module.exports.stream = function(context) {
          return dust.stream(#{JSON.stringify(name)}, context);
        };
      """
    catch err
      error = err
    finally
      callback(error, result)

  include: ->
    modulePath = require.resolve('dustjs-linkedin')
    moduleRoot = systemPath.join(modulePath, '..', '..')
    return systemPath.join(moduleRoot, 'dist', 'dust-core.js')
