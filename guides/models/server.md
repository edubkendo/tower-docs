## Models on the Server

Models on the server work the same as they do on the client, you just have a different set of stores available:

- `Tower.Store.Memory`: in memory
- `Tower.Store.MongoDB`: node-mongo-native driver

I'm working on a Neo4j store right now, and the CouchDB one should be super easy to implement.  If anyone wants to implement a PostGreSQL, MySQL, or SQLite3 store, I'd be happy to include it in!

As with any ORM, sometimes you're going to need direct access to the (in this case) MongoDB driver.  Reasons for this are usually either you're doing some complex/custom/optimized query that requires features outside of the scope of the ORM, or using the ORM overly complicates what you're trying to do (this happens way down the road, and using an ORM is definitely beneficial up front).  You can access the store directly from a model like this:

``` coffeescript
class App.User extends Tower.Model
  @store Tower.Store.MongoDB
  
store = App.User.store()  # instance of Tower.Store.MongoDB
store.lib()               # the core library, such as `require("mongodb")`
```

Sometimes a `Tower.Store` implementation may have more than the base API.  For instance, in `Tower.Store.MongoDB`, you have access to collections and the database connection, which is helpful.
