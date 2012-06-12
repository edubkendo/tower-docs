# Controllers

``` coffeescript
# on the client it has to deserialize `page: 10` back into a hash from a string.
Tower.goTo(Tower.urlFor(App.Post, page: 10))
# keeps the params as a hash, and appends them to the hash, a more optimized way to do it.
Tower.goTo(Tower.urlFor(App.Post), page: 10)
```

On the client there is no middleware (at least yet).  It just complicates things.  Should probably get rid of the idea of `Tower.HTTP.Request` and `Tower.HTTP.Response`.

## Single Page App Flow

### The Server

When a user first comes to your site they can come from any url, such as:

```
/
/posts
/posts/10
```

The server tells us the request is coming from a specific user agent and that the desired format is HTML.

But, since your app works through primarily a JSON API, it should return the same base HTML layout no matter what the request is. And ideally, it should return a base set of data _in addition_ to the data for the specific url they're accessing.

Say you're imagining if they go to the root `/` path, it will bootstrap the current user and the recent posts into the HTML response. That means youre root route, which by default points to `application#welcome` should bootstrap that data.

Now the thing is, conceptually, you're probably going to build out your single page client app _assuming you'll always have that bootstrapped data available_. That means we need to always render that bootstrap data when a user first enters your site, no matter what the path.

To do this, all you need is to have your bootstrap data function be run before any action.

This introduces another complexity though. What if you want to render a path, such as `/faq`, and want it to just to render static HTML like you would in Rails? All you need to do is say `@skipBeforeFilter 'boostrap', only: 'faq'`. This is assuming you use the default controller action implementation, too. If you write your own controller action, you just respond to `html` only.

### The Client

Once you get to the client, you have your bootstrap data that's the same for any path, and the data that's specific to the path.

What happens now is the `App.stateManager` traverses it's states based on the routes, culminating in a call to a controller action on the client. The controller action will, by default, render the Ember view for that action.