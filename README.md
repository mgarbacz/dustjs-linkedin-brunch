## dustjs-linkedin-brunch
Adds [Dustjs (LinkedIn fork)](http://linkedin.github.com/dustjs/) support to
[brunch](http://brunch.io).

## Installation
[![NPM](https://nodei.co/npm/dustjs-linkedin-brunch.png?compact=true)]
(https://nodei.co/npm/dustjs-linkedin-brunch/)

Add `"dustjs-linkedin-brunch": "x.y.z"` to `package.json` of your brunch app.

Pick a plugin version that corresponds to your minor (y) brunch version.

If you want to use git version of plugin, use
`"dustjs-linkedin-brunch": "git@github.com:mgarbacz/dustjs-linkedin-brunch.git"`
instead.

## Usage
Create a template:

    # views/templates/example.dust
    <h1>Hello {name}!</h1>

Require the template into a variable, which creates a render function:

    render_example = require 'views/templates/example'

Call the render function, passing in data and a callback that makes use of the 
rendered output:

    render_example { 'name': 'Batman' }, (error, output) =>
      @$el.html output if not error

For more info on Dustjs itself, visit the
[docs prepared by LinkedIn](http://linkedin.github.com/dustjs/).

## License
[MIT License] (LICENSE.md)
