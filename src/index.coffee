dust = require 'dustjs-linkedin'
systemPath = require 'path'
npm = require 'npm'
fs = require 'fs'

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
    @getDistPath()

  getDistPath: ->
    modulePath = require.resolve('dustjs-linkedin')
    moduleRoot = systemPath.join(modulePath, '..', '..')
    modulePackage = require(systemPath.join(moduleRoot, 'package.json'))
    moduleVersion = modulePackage.version

    systemPath.join(moduleRoot, 'dist', 'dust-core-' + moduleVersion + '.js')
