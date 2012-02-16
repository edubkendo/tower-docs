# Tower Presenters

Helpers are there to manage the global application on the client.  Instead of wrapping components in classes with events and such, it's much easier -- both in reasoning about the system and in managing the system -- to just have a bunch of global methods added to the application in the form of helpers.

## Example: Rendering Helper

``` coffeescript
App.Helpers.PostsHelper =
  extended: ->
    @after "index", "afterIndex"
    @after "create", "afterCreate"
  
  afterIndex: ->
    $(@response.body).appendTo("#content")
```

That pattern is abstracted away into `Tower.Presenter`:

``` coffeescript
class App.PostsPresenter extends App.PostsController
  afterIndex: ->
    $(@response.body).appendTo("#content")
```

or probably better:

``` coffeescript
# app/presenters/postsPresenter
App.PostsPresenter =
  afterIndex: ->
    $(@response.body).appendTo("#content")
```

With presenters, you can event add events to them, which will be added to the global application:

``` coffeescript
App.PostsPresenter =
  events:
    click:
      target:   ".item a.url"
      action:   "toggleItem"
      parents:
        item:   ".item"
      
  extended: ->
    @on "click", "toggleItem", ".item a.url",
      parents:
        item: ".item"
  
  afterIndex: ->
    $(@response.body).appendTo("#content")
    
  toggleItem: ->
    el    = $(@) # == "target"
    item  = el.parents(".item") # from `parents: {item: ".item"}`
```
