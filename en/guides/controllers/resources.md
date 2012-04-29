# `Tower.Controller.Resources`

Tower goes by the convention that every controller represents one resource, one model.

A controller doesn't _need_ to follow these conventions, for example with a `DashboardController` or `SearchController`.  In those cases, overriding the methods starts you with a clean slate.  However, you'll quickly see how powerful this is.

## The Resource

You can customize the variable names and resource type:

``` coffeescript
class App.PostsController extends Tower.Controller
  @resource type: "Article", collection: "articles", resource: "article", key: "data", id: "dataId"
```

## Internals

The default implementation for a `Tower.Controller` looks like this:

``` coffeescript
class App.PostsController extends Tower.Controller
  index: ->
  
  new: ->
  
  create: ->
  
  show: ->
  
  edit: ->
  
  update: ->
  
  destroy: ->
```
