program = require 'commander'

program
  .version('0.0.0')
  .option('-t, --timeout <n>', 'Timeout (s)', parseInt)
  .parse(process.argv)

run = () ->
  if program.timeout
    console.log "Timeout  : " + program.timeout
  console.log   "Arguments: " + program.args

module.exports.run = run
