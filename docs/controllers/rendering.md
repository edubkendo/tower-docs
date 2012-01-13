# Rendering

- Templates
- JSON

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
