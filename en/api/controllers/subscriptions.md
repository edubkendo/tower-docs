# Controller Subscriptions

This section describes how to setup pub/sub in your application.

## `Tower.Controller.subscriptions`

``` coffeescript
class App.PostsController extends App.ApplicationController
  @subscriptions 'all', 'recent', 'archived'
```

You can also use the `publish` method, which is just an alias to `subscriptions`:

``` coffeescript
class App.PostsController extends App.ApplicationController
  @publish 'all', 'recent', 'archived'
```

The keys passed to `subscriptions` point to methods in the controller that return a `Tower.Model.Cursor`.  The _cursor_ is an `Ember.ArrayProxy` that acts as a collection of models matching specific criteria.

``` coffeescript
class App.PostsController extends App.ApplicationController
  @subscriptions 'all', 'recent', 'archived'
  
  all: App.Post.all()
  
  recent: App.Post.recent()
  
  archived: ->
    App.Post.where(authorId: @currentUser.get('id')).archived()
```

You can set the subscription to 1 of 3 things:

1. A `Tower.Model.Cursor` object, which you'll get from `.all()` (see `Tower.Model.Scope` for details).
2. A `Tower.Model.Scope` object, which is everything before you call `.all()`.  This will be converted to a criteria when first called, just makes it so you have to write less code.
3. A `Function`.  This allows you to integrate things like the current user `id` for authentication for example.  However, there will be better ways to grab `currentUser.id` without using a `Function` soon.