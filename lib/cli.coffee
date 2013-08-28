program    = require 'commander'
readline   = require 'readline'
siteStatus = require './index'

defaultTimeout = 10000 # 10s

run = (argv) ->
  program
    .version(require('../../package.json').version)
    .option('-t, --timeout <n>', 'Timeout (ms) default: ' + defaultTimeout, parseInt)
    .parse(argv)

  program.timeout = program.timeout || defaultTimeout

  rl = readline.createInterface
    input:    process.stdin
    output:   process.stdout
    terminal: false

  rl.on 'line', (json) ->
    siteStatus.run program, json, (result) ->
      console.log JSON.stringify(result)

module.exports.run = run
