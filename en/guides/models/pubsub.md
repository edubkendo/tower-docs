# Pub/sub

## Define on the Model

- no real security w/o passing through the controller layer

``` coffeescript
class App.User extends Tower.Model
  @sync() # or...
  @publish() # or...
  @subscribe()
  
  @scope "recent", @where(createdAt: ">=": -> _(2).days().ago()).sync()
```

## Define on the Controller

Need to figure out authorization method first, but this will definitely be more secure.

``` coffeescript
class App.User extends Tower.Model
  @recent: (currentUserId) ->
    # holds permissions
    @where(createdAt: ">=": -> _(2).days().ago()).where(adminId: currentUserId)
  
class App.UsersController extends App.Controller
  @sync "recent", -> @currentUser.get('id')
```
