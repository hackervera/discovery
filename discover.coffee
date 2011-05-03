http = require 'http'
htmlparser = require 'htmlparser'
chainsaw = require 'chainsaw'
request = require 'request'
select = require('soupselect').select

feeds = {}

discover = ->
    return chainsaw (saw)->
        this.find = (host)->
            options = {}
            options.uri = host
            request options, (err, res, body)->
                handler = new htmlparser.DefaultHandler (err, dom)->
                    select(dom, "link").forEach (e)->
                        pat = /(rss|atom)/i
                        href = e.attribs.href
                        if pat.test(e.attribs.type)
                            feeds[href] = href
                parser = new htmlparser.Parser(handler)
                parser.parseComplete(body)
                saw.next()
        this.do = (cb)->
            saw.nest cb, feeds
        return this
module.exports = discover