# Client Extensions

Have CachedCommons.org let you load files with `require('socket.io')`:

``` coffeescript
# coach/controllers/sockets
require('socket.io')

# essentially...
require = (key) ->
  $.getScript("http://cachedcommons.org/javascripts/#{key}.min.js")
```

- underscore.js
- underscore.string.js
- moment.js (date/time)
- mustache.js
- socket.io
- pluralization
- schema.org (https://github.com/indexzero/node-schema-org)
- geo: https://github.com/manuelbieh/Geolib
- tiny-require.js (browser + node)
  - useragent (npm install useragent)
  - shift.js (templating)
  - async.js (callbacks)
  - mimetypes

window.μ = new class Urban
αστικός, == Urban

## Geocoordinates

``` coffeescript
User.within(miles: 10)
```

## Array

- extractArgs (args)
- extractOptions
- extractBlock
- sortBy

## Number

- isInt
- isFloat

## Object

- cloneHash
- cloneArray
- deepMerge
- deepMergeWithArray
- alias
- defineProperty
- accessor
- getter
- setter
- methods
- delegate
- isHash
- kind
- isPresent
- isBlank
- has
- isA

## Function

- functionName

## String

- parameterize
- constantize
- camelize
- underscore
- singularize
- pluralize
- capitalize
- interpolate
- trim

## RegExp

- regexpEscape

## Date

- now
- date