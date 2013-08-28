var npm = require("npm");

npm.load(npm.config, function (er) {
  //catch errors
  npm.commands.list(["dustjs-linkedin"], function (er, data) {
    console.log(data['dependencies']['dustjs-linkedin']['realPath']);
  });
});
