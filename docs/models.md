# Models

``` coffeescript
class App.User extends Tower.Model
  @field "firstName"
```

`Tower.Model` provides a standard set of interfaces for usage in model classes:

- [`Tower.Model.Attributes`](#attributes)
- [`Tower.Model.Callbacks`](#callbacks)
- [`Tower.Model.Changes`](#changes)
- [`Tower.Model.Naming`](#naming)
- [`Tower.Model.Persistence`](#persistence)
- [`Tower.Model.Scoping`](#scoping)
- [`Tower.Model.Validations`](#validations)

`Tower.Model` also helps building custom ORMs for use outside of Tower.js.

`Tower.Model` provides the **same interface** on the client and the server.  When you're on the client, it knows how to store the data in memory or through ajax to the server (more below).  When you're on the server, it's saving it to MongoDB (by default), or CouchDB or Neo4j or wherever.  If the backend store isn't implemented, it's pretty easy for you to add.  See the `Tower.Store` section.

This means you can technically write one set of models and it will work in Node.js and the browser.  Super sweet.  In reality though, you'll want to add functionality specific to the client (jQuery stuff) and server (background jobs like emailing, etc.), but for simple apps you can get away with one set of models!

## Class Methods

This is a complete list of class methods on `Tower.Model`, which includes all of the ActiveModel-compliant "modules" listed above:

- all
- find
- first
- last
- count
- exists
- create
- update
- destroy
- where
- order
- asc
- desc
- page
- paginate
- limit
- offset
- allIn
- anyIn
- notIn
- enqueue
- field
- fields
- relation
- relations
- hasMany
- hasOne
- belongsTo
- toJSON
- fromJSON
- validates
- validators
- scope
- scoped
- defaultScope

## Instance Methods

- changes
- errors
- attributes
- isDirty
- isNew
- isPersisted
- attributeChanged
- attributeChange
- attributeWas
- toUpdates
- get
- set
- has
- assignAttributes
- toLabel
- toPath
- toParam
- toKey
- save
- destroy
- relation
- buildRelation
- createRelation
- toJSON
- clone
- validate

## Example

``` coffeescript
class App.User extends Tower.Model
```

## Server vs. Client

## Flow of Information

Model.create -> scope.create -> model.create -> scope.create -> store.create

@@@ coffeekup
stacktrace "#model-flow-of-information", ["Model.create", "scope.create", "model.create", "scope.create", "store.create"]
@@@

## `Model.create`

When you create models from the class, you can only create one at a time (for now at least):

``` coffeescript
User.create(firstName: "Arthur")
```

When you do that, by default it's going to run the `before "create"` and `before "save"` callbacks, which means it's going to instantiate the record.  You can bypass the model layer entirely (and push save directly to the database) like this:

``` coffeescript
User.create({firstName: "Arthur"}, instantiate: false)
```

Here's whats happening internally.

When you call `Model.create(attributes)`, the `Tower.Store` is going to instantiate a record and pass the compiled attributes to the model constructor.  It's then going to call `Model#save`.  That method then runs through the store again, but this time it doesn't need to be instantiated, it's doing the equivalent of writing directly to the database.  That is, if it passes the validation phase.

## Usage

``` coffeescript
User.batch
User.create
```

## Resources

- http://en.wikipedia.org/wiki/Relational_algebra