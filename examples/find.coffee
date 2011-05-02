discover = require '../discover'
discover()
    .find('www.readwriteweb.com')
    .find('techcrunch.com')
    .do (feeds)->
        for feed in Object.keys feeds
            console.log feed