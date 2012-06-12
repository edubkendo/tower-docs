# HTTP Transactions in Tower

Note: Still figuring out what to call this... transaction/batch-request/etc.

## Overview

When you save a model, the data eventually goes to `Tower.notifyConnections`.  The connections on the client should have a way of writing the data to the server.  This means the "connection" object needs to know how to serialize `create`, `update` and `delete` actions on a record into a URL dynamically.  This means we have to rethink how routes work.

If you have a route to `postsController#index` called `/articles`, you might define that like this:

``` coffeescript
class App.Post extends Tower.Model

class App.PostsController extends Tower.Controller

Tower.Route.draw ->
  @resources 'posts', as: 'article'
```

But, what if you start having nested controllers, such as `App.Admin.PostsController, with route `/admin/posts`.  You might actually have two different names for the same model: the internal `/admin/posts`, and the external `/articles`.  You may want this because, internally, you're okay with reading tables of the models as they actually are, but your client may have a specific niche market where `post` doesn't make sense but `article` does.  So how do you dynamically build these two urls given a single `@post` model from the within the store class?

You can either:

- manually specify the URL when you save the model, maybe `@post.save(url: '/admin/posts')`
- or pass the controller/context with the model to the save method: `@post.save(controllerName: this.constructor.className())`.

Without passing those custom urls, the url will always be `/articles` given a `@post` object, because of the route definitions.  It has no way of distinguishing _which_ route should be used to build the name.

I think it should try to read the url from the model, as a method, and it also passes in the controller it's being called from.  But this will take some time to flesh out because we don't want to start wiring the controller to the model.

Maybe you could tell the current controller that just called the `save` method on the model somehow?

For now, it will just use the default `/posts` route and map to the controller, until we can figure out how to make the dynamics more dynamic :).

## WebSockets and Ajax

The end goal is to make the client send data transparently to server-side controllers, whether through Ajax or WebSockets.  This means that web socket params must be "routed" to the controller actions the same as basic HTTP and Ajax requests do.  This means we'll have to wire web sockets into the express middleware pipeline somehow.  It also means we can instantiate one controller per user/connection per controller class, which will be a decent performance-boosting optimization since you can cache things like the `currentUser`.

To do that, we're also going to have to make logging look the same for each of the different methods.

Finally, if that were implemented, we're only one step away from having a "batch request api".  This way you could update multiple records, even across different controllers, is a single HTTP request:

``` coffeescript
batchRequest [
  {method: 'POST', url: '/posts', data: {title: 'New Post'}},
  {method: 'PUT', url: '/posts/10', data: {title: 'Changed title on this one'}}
]
```

Once we have the method of passing everything through the express middleware layer this will be easy.

```
Request -> Connection -> Middleware -> Router -> Controller (that's cached in the Connection for the specific user/session)
```

We'll have to manage the server-side controllers more clearly, knowing that any variable that was set before an async function may have been _changed_ by the time the async function finishes.  So, use callbacks and don't set any variables.

For now, we'll just instantiate a new controller for each request, no matter what it is.  Later we'll see if we can start reusing the controllers on a per-user basis.