# (in progress) `Tower.Model.Authentication`

``` coffeescript
class App.User extends Tower.Model
  @authenticated 'password'
```

``` coffeescript
user.authenticate('crazy-passwword')
```
