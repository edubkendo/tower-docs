# Dirty Tracking

Tower supports tracking of changed or "dirty" fields with an API that mirrors that of Active Model. If a defined field has been modified in a model the model will be marked as dirty and some additional behaviour comes into play.

## Viewing Changes

There are various ways to view what has been altered on a model. Changes are recorded from the time a document is instantiated, either as a new document or via loading from the database up to the time it is saved. Any persistence operation clears the changes.

``` coffeescript
class User extends Tower.Model
  @field "name", type: "String"

user = User.first
user.set "name", "Alan Garner"

# Check to see if the document has changed.
user.changed() #=> true

# Get an array of the names of the changed fields.
user.changedAttributes() #=> [ "name" ]

# Get a hash of the old and changed values for each field.
user.changes() #=> { "name" : [ "Alan Parsons", "Alan Garner" ] }

# Check if a specific field has changed.
user.changed("name") #=> true

# Get the changes for a specific field.
user.attributeChange("name") #=> [ "Alan Parsons", "Alan Garner" ]

# Get the previous value for a field.
user.attributeWas("name") #=> "Alan Parsons"
```

## Resetting Changes

You can reset changes of a field to it's previous value by calling the reset method.

``` coffeescript
user = User.first()

user.set "name", "Alan Garner"

# Reset the changed name back to the original
user.resetAttribute("name")
user.get("name") #=> "Alan Parsons"
```

## Notes on Persistence

Tower uses dirty tracking as the core of its persistence operations. It looks at the changes on a document and atomically updates only what has changed unlike other frameworks that write the entire document on each save. If no changes have been made, Tower will not hit the database on a call to Model#save.
