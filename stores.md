# Stores

- local html5 storage

``` javascript
var stack = new Error().stack
require("sys").puts( stack )
```



## Store

There's a unified interface to the different types of stores, so you can use the model and have it transparently manage data.  For example, for the browser, you can use the memory store, and for the server, you can use the mongodb store.  Redis, PostgreSQL, and Neo4j are in the pipeline.

``` coffeescript
class PageView extents Coach.Model
  @store "redis"
```