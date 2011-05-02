discover = require '../discover'
nonblock = discover()
    .find('www.readwriteweb.com')
    .find('techcrunch.com')
console.log 'look ma, no blocking'
nonblock
    .find('foo.com')
    .do (feeds)->
        for feed in Object.keys feeds
            console.log feed
console.log 'doing other stuff now, no need to wait'