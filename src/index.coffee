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
      # Need to get template name, so have to get rid of directories in path
      pathSplit = path.split '/'
      pathDirs = pathSplit.length
      path = if pathDirs > 1 then pathSplit[pathDirs - 1] else pathSplit[0]
      # Need to get template name, so have to get rid of '.dust'
      content = dust.compile data, path.replace /\.dust/, ''
      contentJSON = JSON.stringify content
      result = "module.exports = #{content};"
    catch err
      error = err
    finally
      callback error, result

  include: ->
    [ (systemPath.join __dirname,
        '..', '..', 'dustjs-linkedin', 'dist', 'dust-core-2.0.2.js') ]
