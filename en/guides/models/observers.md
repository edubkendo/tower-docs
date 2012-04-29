# Observing and Binding

## Model Binding

See [Ember.js](http://emberjs.com/).

``` coffeescript
class App.User extends Tower.Model
  @field 'firstName', type: 'String'
  @field 'lastName', type: 'String'
  
  fullName: Ember.computed(->
    firstName = @get('firstName')
    lastName  = @get('lastName')

    "#{firstName} #{lastName}"
  ).property('firstName', 'lastName')
  
user = App.User.new(firstName: 'Yehuda', lastName: 'Katz')

user.addObserver 'fullName', (record, key, value) ->
  console.log "New #{key}: #{value}"

user.set('firstName', 'Brohuda') # observer will fire
```

## Collection Binding

``` coffeescript
App.subscribe 'recentUsers', ->
  App.User.where(createdAt: '>=': _(2).days().ago()).all()

App.User.insert()
```

## (todo) Pub/Sub

### Define on the Model

- no real security w/o passing through the controller layer

``` coffeescript
class App.User extends Tower.Model
  @sync() # or...
  @publish() # or...
  @subscribe()
  
  @scope "recent", @where(createdAt: ">=": -> _(2).days().ago()).sync()
```

### Define on the Controller

Need to figure out authorization method first, but this will definitely be more secure.

``` coffeescript
class App.User extends Tower.Model
  @recent: (currentUserId) ->
    # holds permissions
    @where(createdAt: ">=": -> _(2).days().ago()).where(adminId: currentUserId)
  
class App.UsersController extends App.Controller
  @sync "recent", -> @currentUser.get('id')
```


## References

- http://emberjs.com/