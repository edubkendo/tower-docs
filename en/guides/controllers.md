# Controllers

``` coffeescript
# on the client it has to deserialize `page: 10` back into a hash from a string.
Tower.goTo(Tower.urlFor(App.Post, page: 10))
# keeps the params as a hash, and appends them to the hash, a more optimized way to do it.
Tower.goTo(Tower.urlFor(App.Post), page: 10)
```

On the client there is no middleware (at least yet).  It just complicates things.  Should probably get rid of the idea of `Tower.HTTP.Request` and `Tower.HTTP.Response`.