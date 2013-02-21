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
      content = dust.compile data
      contentJSON = JSON.stringify content
      result = "module.exports = #{contentJSON};"
    catch err
      error = err
    finally
      callback error, result

  include: [
    (systemPath.join __dirname, '..', 'vendor',
      'dustjs-core-1.2.0.js')
  ]
