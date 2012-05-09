# Client Controllers

[todo, just notes so far / partial implementation in [development](http://github.com/viatropos/tower/tree/development) branch]

## Overview

Client-side controllers will, like server-side controllers, have a default implementation that _just works_ for the 7 common actions.

## Differences between client and server controllers

- server-side controllers have to respond to different formats (json, html, xml, etc.), client-controllers don't.
- client-side controllers can handle DOM events, keyboard events, socket messages, and urls (using history pushstate), server-controllers only handle urls and socket messages.

## The `index` action.

On the server, the `index` usually fetches a collection of models matching a set of criteria from the database, and renders them into JSON or HTML.  Pretend our server-side index action looks like this:

``` coffeescript
# server-side controller
class App.UsersController extends App.ApplicationController
  index: ->
    App.User.where(createdAt: '>=': _(2).days().ago()).all (error, users) =>
      @render "users/index", locals: {users: users}
```

On the client, when using Ember.js, we want to somehow cache that collection that was returned from `App.User.where...`.

You could do that by refactoring it to a separate method:

``` coffeescript
# client-side controller
class App.UsersController extends App.ApplicationController
  users: ->
    @_users ||= App.User.where(createdAt: '>=': _(2).days().ago()).all
    
  index: ->
    @render "users/index", locals: {users: @users}
```

Assuming the above example was on the client, and assuming `App.User...all` returned a users array, then our `index` action on the client would always render the initial set of users in our client-side store.  If we added users to the client store, we wouldn't see those updates.  (Granted, you could use the first example server-side controller on the client, and you would get the updated users collection, because you're making the query every time, but that's not what we're focusing on).

This is where you start using Ember.js.  One example is to use computed properties, which allows you to define basically a getter/setter:

``` coffeescript
# client-side controller
class App.UsersController extends App.ApplicationController
  users: Ember.computed(->
    App.User.where(createdAt: '>=': _(2).days().ago()).all
  ).cacheable()
    
  index: ->
    @render "users/index", locals: {users: @get('users')}
```

This really doesn't change anything (because Tower's chainable scopes are already `Ember.ArrayProxy` instances, so they're bindable by default).  Also, this client-side controller is starting to look a lot different than the server-side controller:

``` coffeescript
# server-side controller
class App.UsersController extends App.ApplicationController
  index: ->
    App.User.where(createdAt: '>=': _(2).days().ago()).all (error, users) =>
      @render "users/index", locals: {users: users}
```

What if you could make them the same?  You can, like this:

``` coffeescript
# client-side controller
class App.UsersController extends App.ApplicationController
  # don't even need to define it, just showing you
  users: null
  
  index: ->
    @getUsers (error, users) =>
      @render "users/index"
      
  getUsers: (callback) ->
    users = @get('users')
    return callback.call(@, null, users) if users
    App.User.where(createdAt: '>=': _(2).days().ago()).all (error, users) =>
      @set('users', users) # THIS IS KEY
      callback.call(@, error, users)
```

You could use that on both the client and the server.

That simple call to `@set('users', users)` will tell ember to begin watching that collection.  And we only initialize it once - on the server, since every controller is a new instance, this will always be null, but on the client, it will only be null once.

Then, `@render 'users/index'` will, on the client, create a new `Ember.View` if one hasn't been instantiated yet, otherwise it will use a new one.  And on the server, it will just render the HTML string.

Look at this a little closer, you can define scopes to use in your Ember/Handlebars templates!

``` coffeescript
# client-side controller
class App.UsersController extends App.ApplicationController
  # don't even need to define it, just showing you
  users:        null
  recentUsers:  null
  
  index: ->
    if @params.recent == true
      @getRecentUsers (error, users) =>
        @render "users/index"
    else
      @getUsers (error, users) =>
        @render "users/index"
      
  getRecentUsers: (callback) ->
    users = @get('recentUsers')
    return callback.call(@, null, users) if users
    App.User.where(createdAt: '>=': _(2).days().ago()).all (error, users) =>
      @set('recentUsers', users) # THIS IS KEY
      callback.call(@, error, users)
      
  getUsers: (callback) ->
    users = @get('users')
    return callback.call(@, null, users) if users
    App.User.all (error, users) =>
      @set('users', users) # THIS IS KEY
      callback.call(@, error, users)
```

``` html
{{#each App.usersController.recentUsers}}
...
{{/each}}
```

But because you have the `@cursor()` object in the controllers, which is passed to the scope, you can just customize that to scope any list of users.

Just so you know, this is all implemented internally, in a very dynamic way, making it so you don't have to write any code in your controllers and you get this by default.

Now the question pops up, what if you want more for your client-side controllers?  No problem, you are totally free to create a controller specific to the client and one specific to the server, or add stuff specific to the client to the main controller, and just never use that code on the server, it's up to you.  So you could do this:

``` coffeescript
# client-side controller
class App.UsersController extends App.ApplicationController
  # don't even need to define it, just showing you
  users:        App.User.all
  recentUsers:  App.User.where(createdAt: '>=': _(2).days().ago()).all
```

``` html
{{#each App.usersController.recentUsers}}
...
{{/each}}
```

Boom, you set them by default, and they never need to be set again on the client.  Just some ideas.