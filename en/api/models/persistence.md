# `Tower.Model.Persistence`

Tower's standard persistence methods come in the form of common methods you would find in other mapping frameworks.

- `Tower.Model.insert`
- `Tower.Model.update`
- `Tower.Model.destroy`
- `Tower.Model#save`
- `Tower.Model#updateAttributes`
- `Tower.Model#updateAttribute`
- `Tower.Model#destroy`

## `Tower.Model.insert`

Inserts a new record into the datastore given the provided attributes. This will run validations and will return the record whether it was persisted or not. You can check Tower.Model#persisted? to see if it was successful.

``` coffeescript
# Insert a new German poet to the db.
App.User.insert(firstName: 'Heinrich', lastName: 'Heine')
# This can also take a block.
App.User.insert firstName: 'Heinrich', (record) ->
  record.set('lastName', 'Heine')

App.User.insert(firstName: 'Lance')
App.User.where(firstName: 'Lance').insert()
App.User.where(firstName: 'Lance').insert([{lastName: 'Pollard'}, {lastName: 'Smith'}])
App.User.where(firstName: 'Lance').insert(new App.User(lastName: 'Pollard'))
```

## `Tower.Model.update`

``` coffeescript
App.User.update 1, name: 'John', (error, record)
App.User.update 1, 2, 3, name: 'John', (error, records)
App.User.update [1, 2, 3], name: 'John', (error, records)
App.User.update name: 'John', (error, records)

App.User.where(firstName: 'Lance').update(1, 2, 3)
App.User.update(App.User.first(), App.User.last(), firstName: 'Lance')
App.User.update([App.User.first(), App.User.last()], firstName: 'Lance')
App.User.update([1, 2], firstName: 'Lance')
```

## `Tower.Model.destroy`

Deletes all matching records in the datastore given the supplied conditions. See the criteria section on deletion for preferred ways to perform these actions. This runs destroy callbacks on all matching records.

``` coffeescript
# Destroy all the records from the collection.
App.User.destroy()

# Destroy all matching records.
App.User.where(firstName: 'Heinrich').destroy()
```

## `Tower.Model#save`

Saves the record to the datastore. If the record is new then the entire record will be inserted. If the record is already saved then only changes to the record will the persisted. This runs validations by default, however they can be switched off by providing an option to the method. Returns true if validation passed and false if not.

``` coffeescript
# Insert a new German poet to the db.
user = new App.User(firstName: 'Heinrich', lastName: 'Heine')
user.save()

# Save without running validations.
user.save(validate: false)

# Save an existing record's changed fields.
user.set('firstName', 'Christian Johan')

user.save (error) ->
```

## `Tower.Model#updateAttributes`

Modifies the provided attributes to new values and persists them in a single call. This runs validations and will return true if they passed, false if not.

``` coffeescript
# Update the provided attributes.
user.updateAttributes(firstName: 'Jean', lastName: 'Zorg')
```

## `Tower.Model#updateAttribute`

Updates a single attribute in the datastore without going through the normal validation procedure, but does fire callbacks. Returns `true` if save was successful, `false` if not.  These are "atomic updates" in MongoDB.

``` coffeescript
# Update the provided attribute.
user.updateAttribute(:firstName, 'Jean')
```

## `Tower.Model#destroy`

Deletes the record from the datastore while running destroy callbacks.

``` coffeescript
user.destroy()
```
