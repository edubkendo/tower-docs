# (todo) `Tower.Controller.Caching`

## HTTP Caching

### 1. Expiration Headers

- Back-end sets Cache-Control: public, max-age: 60
- Gets cached in gateway cache an browser cache.
- Public says it is good for many clients.
- Cached for 60s.

``` coffeescript
show: ->
  @expiresIn 60.seconds, public: true
  # stuff
  @render
```

### 2. Validation (Conditional Get)

- Back-end adds ETag or Last-modified, e.g. ETag: abcdef012345
- Last-modified is redundant, basically there for HTTP 1.0 clients.
- On 2nd request, gateway cache realizes it has this page in cache, then sends a GET /foo, Host: foo.com, If-None-Match: abcdef012345 to the back-end.
- If back-end returns a 304 Not Modified, gateway cache returns cached version.

``` coffeescript
show: ->
  @foo = Foo.find(@params.id)
  @freshWhen etag: @foo, lastModfied: @foo.get("updatedAt")
```

``` coffeescript
show: ->
  @foo = Foo.find(@params.id)
  if @isStale(etag: @foo, lastModfied: @foo.get("updatedAt"))
    @respondTo ...
```

### Combine Expiration and Validation

- Back-end sets Cache-control: public, max=age=60 and ETag: abcdef012345
- In < 60 seconds, cache-control takes precedence
- After 60 seconds, it queries back-end using ETag
- Back end can then send back a 304 not modified with a new Cache-control: public, max-age: 60

## Resources

- http://pivotallabs.com/users/spierson/blog/articles/842-railsconf-http-s-best-kept-secret-caching-ryan-tomayko-heroku-
