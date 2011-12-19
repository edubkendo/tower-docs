# Sockets

## [TCP](http://en.wikipedia.org/wiki/Transmission_Control_Protocol) (Transmission Control Protocol)

- Socket.io
- Commonly referred to as TCP/IP.
- IP works by exchanging pieces of information called packets. A packet is a sequence of octets and consists of a header followed by a body. The header describes the packet's destination and, optionally, the routers to use for forwarding until it arrives at its destination. The body contains the data IP is transmitting.

## HTTP

## SMTP

## Controllers

``` coffeescript
class PostsController extends Metro.Controller
  @sync "destroy", "create", "update"
  
  destroy: ->
    @post = Post.find(params.id)
    @post.destroy ->
      @respondTo (format) ->
        format.json -> @render json: @post.toJSON()
        format.tcp  -> @broadcast "destroy", @post.toJSON()
```

``` coffeescript
class PostsController extends Metro.Controller
  destroy: ->
    @post = Post.find(params.id)
    @post.destroy ->
      @respondTo (format) ->
        format.json -> @render json: @post.toJSON()
        
  afterDestroy: ->
    @broadcast "destroy", @post.toJSON()
    
  @on "destroy"
```

If user destroys a post:

1. goes to server, destroys post.
2. tells connected clients the post was destroyed
3. message goes to controller#destroy on client, and destroys post.

## Sync actions

Example: Stickies app.  You want to sync every time a new sticky is created

``` coffeescript
class StickiesController extends Metro.ResourceController
  @sync "new", "create", "update", "destroy"
  
  # web socket event!
  move: ->
    self = @
    @sticky = Sticky.find(params.id)
    @sticky.updateAttributes params.sticky, (error) ->
      self.broadcast "moved", self.sticky
      
  moved: ->
    
```

## Sockets

### Server Controller

``` coffeescript
class PostsController extends Metro.Controller
  afterDestroy: ->
    @broadcast "destroy"
```

### Client Controller

``` coffeescript
class PostsController extends Metro.Controller

  destroy: ->
```

If you want to delete a post from the browser, the ideal would be:

1. immediately modify the ui, so it looks like the action was instant to the user.
2. then delete the item.
3. when the deletion succeeds, delete the item on the connected clients

``` coffeescript
Metro.request "delete", Post.first()
#=> goes to PostsController on the client, runs before filters
#=> makes ajax call to server
#=>   server destroys
#=>     server responds with success
#=>       server broadcasts results
#=>     or server responds with failure
#=>       client notifies of error
#=> immediately responds by deleting the element

class Client.PostsController
  destroy: ->
    @post   = Post.find(params.id)
    el      = $("post-#{@post.id}")
    parent  = el.parent()
    el.remove()
    
    # params.sync is true if this is executing in response to a server broadcast
    # that there was a deletion.
    unless params.sync
      @post.destroy (error, result) ->
        if error
          el.appendTo(parent)
          alert "There was an error saving"
```

A refactored version of that could be:

``` coffeescript
class Client.PostsController
  beforeDestroy: (callback) ->
    @post   = Post.find(params.id)
    el      = $("post-#{@post.id}")
    parent  = el.parent()
    el.remove()
    
    # somehow put the sync hidden in here
    callback()
  
  destroy: ->
    @post.destroy (error, result) ->
      if error
        el.appendTo(parent)
        alert "There was an error saving"
```

``` coffeescript
class Server.PostsController
  @sync "destroy"

  destroy: ->
    @post = Post.find(params.id)
    @respondWith @post, (success, failure) ->
      success.json -> @render json: @post.toJSON()
      failure.json -> @render json: @post.errors
```

## Thinking out loud...

I'm wondering what folder structure is the most preferred, easiest to navigate, and easiest to conceptualize/reason about when building a large-scale Node.js app.  It makes sense to start from the Rails conventions, but because both client and server-side code is JavaScript, treating some as "app" code and the rest as just "assets" doesn't make sense.  At the same time, you need some sort of way to write server-side-only and client-side-only JavaScript, while still making it easy to reuse code on both sides.

### Using the same models and controllers on the client and server

I thought you could use the same models and controllers.  For the most basic example apps, you can.  You just have an API on top of the data storage layer, so if you're in the browser you use memory or localStorage, and if your on the server you use MongoDB or whatever.

And for the controllers you can use just default to `layout: false` when you're on the client, and use `after` callbacks to append the response body to the DOM.  I was thinking about encapsulating those into presenters:

``` coffeescript
class PostsController extends BaseController
  
```


## Web Sockets

Web Sockets work just like actions in controllers, using socket.io.

``` coffeescript
class ConnectionsController
  new: ->
    @emit text: "Welcome!"
  
  create: ->
    @broadcast user: params.id, text: params.text
    
  destroy: ->
    @emit text: "Adios"
```