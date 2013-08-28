request = require 'request'
cheerio = require 'cheerio'

msDiff = (t1, t2) ->
  s = t2[0] - t1[0]
  mms = t2[1] - t1[1]
  return (s*1e9 + mms)/1000/1000

statusCode = (res) ->
  status =
    try
      res.statusCode
    catch
      0

  if      200 <= status and status < 300
    return "200"
  else if 400 <= status and status < 500
    return "400"
  else if 500 <= status and status < 600
    return "500"
  else
    return "***"

run = (program, json, callback) ->
  timeout = program.timeout

  data = JSON.parse json
  site  = data.site
  url   = data.url
  stats = data.stats

  t1 = process.hrtime()
  request.get
    url:     url
    timeout: timeout
  , (error, res, body) ->
    t2 = process.hrtime()

    result = {}
    result.site = site
    result.url  = url
    result.time = msDiff(t1, t2)

    result.code = statusCode(res)

    if error
      result.error = error.code
    else
      $ = cheerio.load body
      result.stats = {}
      Object.keys(stats).forEach (key) ->
        value = $(stats[key]['selector']).text()
        if      stats[key]['type'] == 'numeric'
          result.stats[key] = parseFloat(value)
        else if stats[key]['type'] == 'string'
          result.stats[key] = value

    callback(result)

module.exports.run = run
