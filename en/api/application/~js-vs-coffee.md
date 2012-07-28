# Writing your app in JavaScript vs. CoffeeScript

## Tower With JavaScript

``` javascript
# config/application.js
App = Tower.Application.extend()

# app/models/user.js
App.User = Tower.Model.extend({
  firstName: Tower.Model.Attribute.create(type: 'String')
})

# app/controllers/usersController.js
App.UsersController = Tower.Controller.extend(
  index: function() {
    var _this = this;
    App.User.all(function(error, records) {
      _this.render('index', {locals: {users: records}});
    })
  }
)
```

## Tower With CoffeeScript

``` javascript
# config/application.coffee
class App extends Tower.Application

# app/models/user.coffee
class App.User extends Tower.Model
  @field 'firstName'
  
# app/controllers/usersController.coffee
class App.UsersController extends Tower.Controller
  index: ->
    App.User.all (error, records) =>
      @render 'index', locals: users: records
```

