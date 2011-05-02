discover = require '../discover'
discover()
    .find('www.readwriteweb.com')
    .do (feeds)->
        console.log feeds
    .find('techcrunch.com')
    .do (feeds)->
        console.log feeds