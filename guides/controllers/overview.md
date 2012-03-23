# Overview

## Class Methods

- beforeAction
- afterAction
- helper
- layout
- params
- param
- resource
- resourceType
- resourceName
- collectionName
- respondTo
- belongsTo
- on

## Instance Methods

- index
- new
- create
- show
- edit
- update
- destroy
- headers
- params
- format
- action
- criteria
- head
- render
- renderToString
- broadcast
- emit
- respondWith
- respondTo
- redirectTo

## Example

``` coffeescript
class PostsController extends Tower.Controller
  index: ->
    @posts = Post.all()
    
  new: ->
    @post = Post.new
    
  create: ->
    @post = Post.new(params.post)
    
    super (success, failure) ->
      success.html -> render "posts/edit"
      success.json -> render text: "success!"
      failure.html -> render text: "Error", status: 404
      failure.json -> render text: "Error", status: 404
    
  show: ->
    @post = Post.find(params.id)
    
  edit: ->
    @post = Post.find(params.id)
    
  update: ->
    @post = Post.find(params.id)
    
  destroy: ->
    @post = Post.find(params.id)
```