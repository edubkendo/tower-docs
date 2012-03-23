# Rendering

- Templates
- JSON
- The Rendering Process

## Templates

``` coffeescript
class App.PostsController extends Tower.Controller
  index: ->
    @render "index"
```

## JSON

``` coffeescript
class App.PostsController extends Tower.Controller
  show: ->
    App.Post.find @params.id, (error, post) =>
      @render json: post
```

## The Rendering Process

### `respondWith`

``` coffeescript
show: ->
  App.Post.find @params.id, (error, post) =>
    @respondWith post, (format) =>
      format.html => @render "show"
```

This will perform _content negotiation_, i.e. it will figure out what the mime type the browser prefers and run the corresponding responder method (for html, json, csv, etc.).  Those methods then call the `render` method.

### `render`

``` coffeescript
show: ->
  App.Post.find @params.id, (error, post) =>
    @render "show"
```

Calling the render method directly forces a specific content type to be rendered.  Here is the method signature:

``` coffeescript
render json: {hello: "world"}
render "show"                 # render action: "show"
render "posts/show"           # render file: "posts/show"
render -> h1 "Hello World"
render text: "success", status: 200
```

### `_normalizeRender`

This converts the render arguments into a normalized options hash.

### `_renderToBody`

### `_renderOption`

### `_renderTemplate`

