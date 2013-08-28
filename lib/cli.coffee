program    = require 'commander'
readline   = require 'readline'
siteStatus = require './index'

run = (argv) ->
  program
    .option('-t, --timeout <n>', 'Timeout (s)', parseInt)
    .parse(argv)

  rl = readline.createInterface
    input:    process.stdin
    output:   process.stdout
    terminal: false

  rl.on 'line', (json) ->
    siteStatus.run json, (result) ->
      console.log JSON.stringify(result)

module.exports.run = run
