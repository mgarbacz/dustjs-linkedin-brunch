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
      content = dust.compile data, path.replace /\.dust/, ''
      contentJSON = JSON.stringify content
      result = "module.exports = #{content};"
    catch err
      error = err
    finally
      callback error, result

  include: ->
    [ (systemPath.join __dirname,
        '..', 'node_modules', 'dustjs-linkedin', 'dist', 'dust-core-2.0.0.js') ]
