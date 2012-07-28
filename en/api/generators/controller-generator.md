# Controller Generator

To create a Controller for the User model, execute the Controller Generator like this:

```
tower generate controller Post
```

The controller should generate a single controller file:

```
|-- app
|   |-- controllers
|   |   |   `-- postsController.coffee
```

The controller will initially be empty:

``` coffeescript
class App.PostsController extends Tower.Controller
```

Fill it out as needed:

``` coffeescript
class App.PostsController extends Tower.Controller
  @respondTo "html", "json"

  new: ->
    @posts = Post.all()
```

