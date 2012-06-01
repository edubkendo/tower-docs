# Client StateManager

https://gist.github.com/2679013

``` coffeescript
class App.PostsController extends Tower.Controller
  # simple case
  index: ->
  
  # more control
  index:
    enter: ->
    exit: ->
```
