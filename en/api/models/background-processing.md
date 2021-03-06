# Background Processing

``` coffeescript
class App.User extends Tower.Model
  @after 'create', 'welcome'

  @sendWelcomeEmail: (id) ->
    App.User.find id, (error, user) =>
      App.Notification.welcome(user).deliver()
    
  welcome: ->
    App.User.enqueue 'sendWelcomeEmail', @get('id')
```

In the above example, after a User is created we call it's `welcome` method.  That queues a class method, passing the user `id` as a parameter.  You pass the `id` rather than the whole User model to the `queue` method because this is going to be serialized to some backend key-value store, like Redis, and it's both a smaller amount of data to store, and it's easier to serialize/deserialize just an id.
