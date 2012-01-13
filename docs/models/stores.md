# Stores

There's a unified interface to the different types of stores, so you can use the model and have it transparently manage data.  For example, for the browser, you can use the memory store, and for the server, you can use the mongodb store.  Redis, PostgreSQL, and Neo4j are in the pipeline.

``` coffeescript
class App.Page extents Tower.Model
  @store "mongodb"
```

## Resources

# Stores are the interface models use to find their data.
# http://www.w3.org/TR/IndexedDB/
# https://github.com/kriszyp/perstore

# all()  
# all(title: "Title")
# all({title: "Title"}, {safe: true})
# all({title: "Title"}, {safe: true}, (error, records) ->)
# You can only do the last one!