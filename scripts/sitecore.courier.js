"use strict"
var exec = require('child_process').exec;

var courier = {};

courier.runner = function runner(args, callback) {
  var cmdline = "\"./lib/Sitecore.Courier/Sitecore.Courier.Runner.exe\" " + args;
  console.log(cmdline);

  exec(cmdline, function(err, stdout, stderr) {
     console.log(stdout);
     console.log(stderr);
     callback(err);
  });
};

module.exports = courier;