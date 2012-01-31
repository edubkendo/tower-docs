# Models

``` coffeescript
class App.Post extends Tower.Model
```

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