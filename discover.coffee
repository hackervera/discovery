http = require 'http'
htmlparser = require 'htmlparser'
chainsaw = require 'chainsaw'
select = require('soupselect').select

feeds = {}

discover = ->
    return chainsaw (saw)->
        this.find = (host)->
            feeds = {}
            body = ""
            options = {}
            options.host = host
            req = http.request options, (res)->
                res.on 'data', (chunk)->
                    body += chunk
                res.on 'end', ->
                    handler = new htmlparser.DefaultHandler (err, dom)->
                        select(dom, "link").forEach (e)->
                            pat = /(rss|atom)/i
                            href = e.attribs.href
                            if pat.test(e.attribs.type)
                                feeds[href] = href
                    parser = new htmlparser.Parser(handler)
                    parser.parseComplete(body)
                    saw.next()
            req.end()
        this.do = (cb)->
            saw.nest cb, feeds
        return this
module.exports = discover