dust = require 'dustjs-linkedin'
fs = require 'fs'
sysPath = require 'path'

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
                module.exports.requirePath = #{JSON.stringify(name)};
                module.exports.render = function(context, callback){return dust.render(#{JSON.stringify(name)}, context, callback);};
                module.exports.stream = function(context){return dust.stream(#{JSON.stringify(name)}, context);};
            """
        catch err
            error = err
        finally
            callback(error, result)

    include: ->
        includes = []
        try
            # include the latest version of dustjs-linkedin, if present
            dustServer = require.resolve('dustjs-linkedin')
        catch moduleNotFound
            # include non-linkedin version if present
            dustServer = require.resolve('dust')

        dustRoot = sysPath.resolve(dustServer, '../..')
        if fs.existsSync(sysPath.resolve(dustRoot, 'dist/dust-core.js'))
            dustVersion = ''
        else
            # try to find the versioned dist file
            dustPackage = require(sysPath.resolve(dustRoot, 'package.json')).version
            dustVersion = '-' + dustPackage.version

        if @includeCompiler
            dustClient = sysPath.resolve(dustRoot, "dist/dust-full#{dustVersion}.js")
        else
            dustClient = sysPath.resolve(dustRoot, "dist/dust-core#{dustVersion}.js")
        includes.push(dustClient)

        # include linkedin/dustjs-helpers if present
        try
            dustHelpers = require.resolve('dustjs-helpers')
            includes.push(dustHelpers)

        # include common-dustjs-helpers if present
        try
            commonHelpers = require.resolve('common-dustjs-helpers')
            commonHelpersClient = sysPath.resolve(commonHelpers, '../common-dustjs-helpers.js')
            includes.push(commonHelpersClient)

        return includes
