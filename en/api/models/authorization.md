# (in progress) `Tower.Model.Authorization`

``` coffeescript
class App.User extends Tower.Model
```

``` coffeescript
class App.Ability extends Tower.Model
```

``` coffeescript
class App.ApplicationController extends Tower.Controller
  @beforeAction 'setCurrentUser'
  @beforeAction 'setCurrentAbility'
  
  setCurrentUser: (next) ->
    App.User.first (error, user) => # need to use a real solution with sessions, etc.
      @currentUser = user
      next()
  
  setCurrentAbility: ->
    @currentAbility = new App.Ability(@currentUser)
```
