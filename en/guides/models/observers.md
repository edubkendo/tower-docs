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

user.set('firstName', 'Brohuda'); # observer will fire
```

## Collection Binding

``` coffeescript
App.subscribe 'recentUsers', -> App.User.where(createdAt: '>=': _(2).days().ago()).all()

App.User.insert()
```

## (todo) Pub/Sub



## References

- http://emberjs.com/