discover = require '../discover'
nonblock = discover()
    .find('http://www.readwriteweb.com')
    .find('http://www.techcrunch.com')
console.log 'look ma, no blocking'
nonblock
    .find('http://www.foo.com')
    .do (feeds)->
        for feed in Object.keys feeds
            console.log feed
console.log 'doing other stuff now, no need to wait'