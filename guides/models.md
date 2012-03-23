# Models

``` coffeescript
class App.User extends Tower.Model
  @field "firstName"
```

All of the examples on this page assume `Tower.Model` is using the memory datastore `Tower.Store.Memory`, which doesn't require a callback in any of its finder/persistence methods.  Makes it easier to read and play around with.