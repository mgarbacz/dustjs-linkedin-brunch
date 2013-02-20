## dustjs-linkedin-brunch
Adds [Dustjs (LinkedIn fork)](http://linkedin.github.com/dustjs/) support to
[brunch](http://brunch.io).

## Installation
Add `"dustjs-linkedin-brunch": "x.y.z"` to `package.json` of your brunch app.

Pick a plugin version that corresponds to your minor (y) brunch version.

If you want to use git version of plugin, add
`"dustjs-linkedin-brunch": "git@github.com:mgarbacz/dustjs-linkedin-brunch.git"`
.

## Usage
Create a template:

    # views/templates/example.dust
    <h1>Hello {{name}}!</h1>

Require the template into a variable:

    template = require 'views/templates/example'

Load template into the `dust.cache` object:

    dust.loadSource template

Render the template:

    dust.render 'example', { 'name': 'Batman' }, (error, output) =>
      @$el.html output if not error

If you want to render templates within the browser, include the 
`"dustjs-core-x.y.z.js"` file with your script tags in your html 

For more info visit the
[docs prepared by LinkedIn](http://linkedin.github.com/dustjs/)
