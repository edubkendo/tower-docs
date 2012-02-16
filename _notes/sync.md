# Approaches to the `sync` method

## `Tower.sync`

Global method that you override

Pros:

- Easy to get up and running with
- One entry point

Cons:

What if I don't want to sync, just mess around with models on the client?  I can create another store...  What if I want to sync in batches?  Complex store extending store then...

## `Tower.Store.Ajax extends Tower.Store.Memory`

Extend the basic store.

## URL

There are several ways you can define a url:

#### 1. Using the `url` class method

``` coffeescript
class App.Post extends Tower.Model
  @sync "/articles"
  
class App.Comment extends Tower.Model
  @sync belongsTo: "Post"
```

#### 2. Using the `url` prototype method

``` coffeescript
class App.Post extends Tower.Model
  sync: "/articles"
  
class App.Comment extends Tower.Model
  sync: (method) ->
    "/articles/#{@post().get("id")}/comments"
```

## Custom Store

## Ideas

``` coffeescript
class App.PostsController extends App.ApplicationController
  @on "syncCreateSuccess"
  
  syncCreateSuccess: 

record.save sync: false, (error) =>
  unless error
    
  create: ->
    @_create (success, failure) =>
      success.html ->
        @render "admin/posts/index"
        @resource.sync "create", (error) =>
          
      success.ajax ->
      
  create: ->
    resource.save (error) =>
      resource.sync
  
  afterCreate: ->
    
  afterSyncCreate: ->
      
Post.sync().create()
Post.createSync()
Post.create()
Post.sync()
post.updateAttribute
post.save sync: false, (error) =>
  post.destroy =>
    post.sync()
post.save(sync: true)

Tower.Model.Sync =
  sync: ->
    syncAction = @syncAction
    @runCallbacks "sync", =>
      @runCallbacks "#{syncAction}Sync", =>
        @store["#{syncAction}Sync"](@)
    
  updateSyncAction: (action) ->
    @syncAction = action # create, update, delete
      # if it was create, and it's never been synced, then we can just remove it from memory and be all cool
      when "delete" then "delete"
        switch @syncAction
          when "update" then "delete"
          else
            action
      else
        action
        
      when "update"
        switch @syncAction
          when "create" then "create"
          else
            "update"
            
Tower.Store =
  readSync: ->
    @sync.read
    
  createSync: ->
    @sync.create
    
  updateSync: ->
    @sync.update
    
  destroySync: ->
    @sync.destroy
```