# Controller Params-to-Criteria

``` coffeescript
class App.PostsController extends Tower.Controller
  @param "title"
  @param "body"
  @param "firstName", "user.firstName"
```

``` coffeescript
class App.PostsController extends Tower.Controller
  @params limit: 20, ->
    @param "title"
    @param "body"
```
