# Todo

## Binding

It's easy to do binding from a model to a view, because we're creating the models and can dispatch events.  Without events, you have to run a timer.

Manual form:

``` coffeescript
post = new Post(title: "First Post")

Tower.bind $("#title").get(0), "innerHTML", post, "title"
Tower.bind $("title").get(0), "innerHTML", post, "title"
```

## Collections

Need a better way to handle $push, $pop, etc.

Maybe:

``` coffeescript
set: (options) ->
  if options.$push
    for key, value of options.$push
      oldValue = @attributes[key]
      newValue = oldValue.concat().push(value)
      @changes[key] = [@attributes[key], newValue, value] # [old, new, diff]
```

The above will give you a way of being notified when any attribute changes.

## Events on Scopes

``` coffeescript
scope = User.where(active: true)
scope.on "create"
scope.on "update"
scope.on "destroy"
```

The problem with the above approach is if you had 10 scopes all with these event handlers, you'd have to iterate through all of them every time a model was added, even though the model may have matched the first scope only (technically several scopes might match a given record).

It's probably easier/clearer to just listen to any model that's added and manually check:

``` coffeescript
scope = User.where(active: true)
User.on "create", (error, model) ->
  if scope.contains(model)
    # ...
```

- http://stackoverflow.com/questions/1992902/add-new-gist-using-the-github-api
- https://github.com/emerleite/node-gist
- Integration with Ember.js on client?
- Hardcore event dispatching framework?
- setup multiple versions of node.js locally to test your app against.