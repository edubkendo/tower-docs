# Persistence

Tower's standard persistence methods come in the form of common methods you would find in other mapping frameworks.

- `Model.create`
- `Model.delete`
- `Model.destroy`
- `Model#save`
- `Model#updateAttributes`
- `Model#updateAttribute`
- `Model#delete`
- `Model#destroy`

## `Model.create`

Inserts a new document into the database given the provided attributes. This will run validations and will return the document whether it was persisted or not. You can check Model#persisted? to see if it was successful.

### Model

``` coffeescript
# Insert a new German poet to the db.
Person.create(firstName: "Heinrich", lastName: "Heine")
```

# This can also take a block.
Person.create firstName: "Heinrich", (record) ->
  doc.lastName = "Heine"

### Store

``` coffeescript
store.create { "firstName" : "Heinrich", "lastName" : "Heine" }
```

## `Model#save`

Saves the document to the database. If the document is new then the entire document will be inserted. If the document is already saved then only changes to the document will the persisted. This runs validations by default, however they can be switched off by providing an option to the method. Returns true if validation passed and false if not.

### Model

``` coffeescript
# Insert a new German poet to the db.
person = Person.new(firstName: "Heinrich", lastName: "Heine")
person.save()

# Save without running validations.
person.save(validate: false)

# Save an existing document's changed fields.
person.firstName = "Christian Johan"
person.save()
```

### Store

``` coffeescript
# Insert command for the new document.
collections["people"].insert({
  "_id" : ..., "firstName" : "Heinrich", "lastName" : "Heine"
})

# Update command for the changed document.
collections["people"].update({
  { "_id" : ... },
  { "$set" : { "firstName" : "Christian Johan" } }
})
```

## `Model#updateAttributes`

Modifies the provided attributes to new values and persists them in a single call. This runs validations and will return true if they passed, false if not.

### Model

``` coffeescript
# Update the provided attributes.
person.updateAttributes(firstName: "Jean", lastName: "Zorg")
```

### Store

``` coffeescript
# Update command for the changed document.
collections["people"].update({
  { "_id" : ... },
  { "$set" : { "firstName" : "Jean", "lastName" : "Zorg" } }
})
```

## `Model#updateAttribute`

Updates a single attribute in the database without going through the normal validation procedure, but does fire callbacks. Returns true if save was successful, false if not.

### Model

``` coffeescript
# Update the provided attribute.
person.updateAttribute(:firstName, "Jean")
```

### Store

``` coffeescript
# Update command for the changed document.
collections["people"].update({
  { "_id" : ... },
  { "$set" : { "firstName" : "Jean" } }
})
```

## `Model#delete`

Deletes the document from the database without running callbacks.

### Model

``` coffeescript
person.delete()
```

### Store

``` coffeescript
collections["people"].remove("_id" : ... )
```

## `Model#destroy`

Deletes the document from the database while running destroy callbacks.

### Model

``` coffeescript
person.destroy()
```

### Store

``` coffeescript
collections["people"].remove("_id" : ... )
```

## `Model.delete`

Deletes all matching documents in the database given the supplied conditions. See the criteria section on deletion for preferred ways to perform these actions. This does not run any callbacks on the matching documents.

### Model

``` coffeescript
# Delete all the documents from the collection.
Person.delete()

# Delete all matching documents.
Person.where(firstName: "Heinrich").delete()
```

### Store

``` coffeescript
# Delete all command.
collections["people"].remove

# Delete all matching command.
collections["people"].remove("firstName" : "Heinrich")
```

## `Model.destroy`

Deletes all matching documents in the database given the supplied conditions. See the criteria section on deletion for preferred ways to perform these actions. This runs destroy callbacks on all matching documents.

### Model

``` coffeescript
# Destroy all the documents from the collection.
Person.destroy()

# Destroy all matching documents.
Person.where(firstName: "Heinrich").destroy()
```

### Store

``` coffeescript
# Destroy all command.
collections["people"].remove

# Destroy all matching command.
collections["people"].remove("firstName" : "Heinrich")
```
