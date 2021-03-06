# `Tower.Model.Data`

Tower supports tracking of changed or "dirty" fields with an API that mirrors that of Active Model. If a defined field has been modified in a model the model will be marked as dirty and some additional behavior comes into play.

## Viewing Changes

There are various ways to view what has been altered on a model. Changes are recorded from the time a record is instantiated, either as a new record or via loading from the database up to the time it is saved. Any persistence operation clears the changes.

``` coffeescript
class App.User extends Tower.Model
  @field 'name', type: 'String'

user = App.User.first()

# Check to see if the record has changed.
user.isDirty() #=> false

user.set('name', 'Alan Garner')

# Check to see if the record has changed.
user.get('isDirty') #=> true

# Get a hash of the old and changed values for each field.
user.get('changes') #=> { 'name' : [ 'Alan Parsons', 'Alan Garner' ] }

# Get the changes for a specific field.
user.attributeChange('name') #=> [ 'Alan Parsons', 'Alan Garner' ]

# Get the previous value for a field.
user.attributeWas('name') #=> 'Alan Parsons'
```

## Resetting Changes

You can reset changes of a field to it's previous value by calling the reset method.

``` coffeescript
user = App.User.first()

user.set('name', 'Alan Garner')

# Reset the changed name back to the original
user.resetAttribute('name')

user.get('name') #=> 'Alan Parsons'
```

## Notes on Persistence

Tower uses dirty tracking as the core of its persistence operations. It looks at the changes on a record and atomically updates only what has changed unlike other frameworks that write the entire record on each save. If no changes have been made, Tower will not hit the database on a call to Model#save.
