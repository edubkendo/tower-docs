# Authentication

## Model

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

- https://github.com/ryanb/cancan/wiki/Defining-Abilities

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
