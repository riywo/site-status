# site-status

Ping web sites and get status

## What is this?

Like [pingdom](https://www.pingdom.com/) or [keynote](http://www.keynote.com/), `site-status` access some endpoints of web sites and gets the "Site Status".

Example:

    $ cat ./example/github.json
    { "site": "github", "url": "https://status.github.com/", "stats": { "GitHub": { "selector": "div.service:nth-of-type(1) span.status", "type": "string" } , "App Server %": { "selector": "div.graph div.data:nth-of-type(1) span.number", "type": "numeric" } } }

    $ cat ./example/github.json | site-status
    {"site":"github","url":"https://status.github.com/","time":1100,"code":"200","stats":{"GitHub":"Normal","App Server %":100}}

## "Site Status"?

### status code

HTTP status code.

### response time

Response time of the HTTP request.

### in the content

Some sites have "status" value in their contents of the sites. `site-status` can scrape the value.

**Currently only HTML and CSS selector.** JSONPath will be supported soon.

## Installation

    npm install -g site-status

## Usage

`site-status` reads STDIN line by line as a site configuration JSON object, get the sites and writes STDOUT line by line as a site status.

### site configuration (STDIN)

#### site

Name of the site

#### url

URL of the site endpoint

#### stats

- key: name of the stat
- value:
    - selector: CSS selector
        - see also: [CSSselect](https://npmjs.org/package/CSSselect)
    - type: `numeric` or `string`

#### example

You have to use a single line JSON.

    { "site": "github", "url": "https://status.github.com/", "stats": { "GitHub": { "selector": "div.service:nth-of-type(1) span.status", "type": "string" } , "App Server %": { "selector": "div.graph div.data:nth-of-type(1) span.number", "type": "numeric" } } }

pretty print:

    {
        "site": "github",
        "url": "https://status.github.com/",
        "stats": {
            "App Server %": {
                "selector": "div.graph div.data:nth-of-type(1) span.number",
                "type": "numeric"
            },
            "GitHub": {
                "selector": "div.service:nth-of-type(1) span.status",
                "type": "string"
            }
        }
    }

### site status (STDOUT)

#### site

Same as the site configuration

#### url

Same as the site configuration

#### code

HTTP status code (200, 400, 500 or ***)

#### time

Response time (ms)

#### stats

Scraped status

#### example

    {"site":"github","url":"https://status.github.com/","time":912,"code":"200","stats":{"GitHub":"Normal","App Server %":100}}

pretty print:

    {
        "site": "github",
        "url": "https://status.github.com/",
        "code": "200",
        "time": 912,
        "stats": {
            "App Server %": 100,
            "GitHub": "Normal"
        }
    }

### help

      Usage: site-status [options]
    
      Options:
    
        -h, --help         output usage information
        -V, --version      output the version number
        -t, --timeout <n>  Timeout (ms) default: 10000

## License

MIT

## Author

Ryosuke IWANAGA a.k.a. riywo
