# Actions

By convention there are 7 RESTful actions for a controller:

1. `index`: Show all resources (`GET`)
2. `new`: Build a new resource and render a form (`GET`)
3. `create`: Create a new resource (`POST`)
4. `show`: Find and show a resource by id (`GET`)
5. `edit`: Find a resource by id and render it in a form to edit (`GET`)
6. `update`: Update an existing resource (`PUT`)
7. `destroy`: Destroy an existing resource (`DELETE`)

If you wanted to manually write out simple controller actions, this is how you might do it:

``` coffeescript
class App.PostsController extends Tower.Controller
  index: ->
    App.Post.all (error, posts) =>
      @render "index", locals: posts: posts
    
  new: ->
    post = new App.Post
    @render "new", locals: post: post
    
  create: ->
    App.Post.create @params.post, (error, post) =>
      @redirectTo post
    
  show: ->
    App.Post.find @params.id (error, post) =>
      @render "show", locals: post: post
    
  edit: ->
    App.Post.find @params.id (error, post) =>
      @render "edit", locals: post: post
    
  update: ->
    App.Post.find @params.id (error, post) =>
      post.updateAttributes @params.post, (error) =>
        if error
          @render "edit", locals: post: post
        else
          @redirectTo post
    
  destroy: ->
    App.Post.find @params.id (error, post) =>
      post.destroy (error) =>
        @redirectTo "index"
```

**Note**: The above actions won't respond to different content types differently (i.e. for json, give me a json string, for html give me some rendered html).  But for some cases that's all you need.

In order for those actions to be accessible, routes must be defined.  Routes to all 7 RESTful actions are generated with the following declaration in `config/routes.coffee`:

``` coffeescript
Tower.Route.draw ->
  @resources "posts"
```

More on routes in the [routes section](/docs/routes).

## Custom Actions

Sometimes RESTful actions aren't enough.  To add custom actions, just add a route mapping to the method name for the controller.

``` coffeescript
Tower.Route.draw ->
  @resources "posts", ->
    @get "dashboard"
```

**Note**: If you start thinking you need to add a custom action to your controller, I personally recommend asking the community (stack overflow, twitter, github, etc.) if there's a way to fit it into the paradigm.  Several times I thought "this is the one time I need a custom action", but 99% of the time I found a way to fit it in.  This always simplified the system.