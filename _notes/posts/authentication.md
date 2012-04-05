# Authentication

Tower plans to support multiple Authentication modules at some point. For starters we plan to support [Passport](https://github.com/jaredhanson/passport).

## Passport

- [Passport site](http://passportjs.org/)
- [Passport Guide](http://passportjs.org/guide/index.html)

``` javascript
app.post('/login',
  passport.authenticate('local', { successRedirect: '/',
                                   failureRedirect: '/login' })
);
```

Before asking Passport to authenticate a request, the strategy (or strategies) used by an application must be configured.

Strategies, and their configuration, are supplied via the `use()` function. For example, the following uses the `LocalStrategy` for username/password authentication.

``` javascript
var passport = require('passport')
  , LocalStrategy = require('passport-local').Strategy;

passport.use(new LocalStrategy(
  function(username, password, done) {
    User.findOne({ username: username }, function(err, user) {
      if (err) { return done(err); }
      if (!user) {
        return done(null, false, { message: 'Unknown user' });
      }
      if (!user.validPassword(password)) {
        return done(null, false, { message: 'Invalid password' });
      }
      return done(null, user);
    });
  }
));
```

From the Passport guide:

"In a Connect or Express-based application, passport.initialize() middleware is required to initialize Passport. If your application uses persistent login sessions, passport.session() middleware must also be used."

In Application configuration function we need to set up the Passport middleware to use:

``` coffeescript
  @use passport.initialize()
  @use passport.session()
```

## Model

A User might be modelled along the following lines...

``` coffeescript
class User extends Metro.Model
  @embedsMany "authorizations"
  
  @findFromSession: (session) ->
    token = session?.cookies["connect.sid"]
    return unless token
    
    @where(persistentToken: token).first()
  
class Authorization extends Metro.Model
  @embeddedIn "user"
```

## Controller

The ApplicationController could be setup to have a `beforefilter` similar to the typical approach in Rails.
The filter would then ensure that a user can be found in the user session before authorizing the user to access a given view.

``` coffeescript
class ApplicationController extends Metro.Controller
  @beforeFilter "currentUser"
  
  currentUser: ->
    @currentUser ||= User.findFromSession(@session)
  
class AuthorizationsController extends ApplicationController
  create: ->
    @user = User.create(params.auth)
    
class SessionsController extends Metro.Controller
  
```

## Authorization

We would like to have a simple `cando` module which implements a simple authorization approach similar to _CanCan_ for Rails. For inspiration see here:

- [cancan abilities](https://github.com/ryanb/cancan/wiki/Defining-Abilities)

``` coffeescript
class Ability extends CanCan.Ability
  constructor: (user) ->
    if @user.admin
      @can "update", Article
    
    @can "read", Article
```

## Views

``` html
- if can "read", Article
  ul
    li Articles!
    
- if can "update", Article
  input(type='submit', value='Save')
```