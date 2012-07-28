# Deep Dive into Tower Models

## Instantiating a record

To instantiate a record you have two options, to use `build` or `new`:

``` coffeescript
user = App.User.build()
user = App.User.new()
```

In JavaScript, you can't use the `new` keyword directly, so it's probably best to use `build`.

The `build` and `new` functions are aliases to `Ember.Object.create`.  The reason we did this was because, when dealing with database records specifially, the `create` method intuitively should actually persist a record to the database.  So, `App.User.create` builds the object using `App.User.build` as well as saves it to the database.  We thought about calling this method `insert` rather than `create`, but `insert` doesn't feel like it should return a record.  In summary, App.User.build is the same as Ember.Object.create, which just constructs an object in JavaScript in memory, while App.User.create has the additional functionality of persisting it to the database.  Just wanted to avoid confusion there.

Currently you shouldn't instantiate a model (or anything in Tower or Ember, really) with the native JavaScript constructor function:

``` coffeescript
user = new App.User
```

The reason for this is because Tower models extend `Ember.Object`, and `Ember.Object.create` is implemented differently than `new Ember.Object`.  This API may be made simpler in the future.

When you instantiate a record, you can pass it attributes:

``` coffeescript
user = App.User.build(email: 'example@localhost.com')
```

For those of you from the Ember world, this roughly equivalent to:

``` coffeescript
Ember.Object.create().setProperties(email: 'example@localhost.com')
```

When you instantiate a record without persisting it, it will not be added to any published cursor.  To add it to a cursor without persisting it to the database, you can call `Tower.Model.Cursor.push(records)` and it will add it to the published cursors.  If the record is persisted, however, `Tower.Model.Cursor.push(record)` will be called automatically.

## Creating a record

You can create a record from a model's class or instance:

``` coffeescript
user = App.User.create()
user = App.User.build()
user.save()
```

Whenever you create a record like this, it will be saved to the database.  If you're on the client, it will use either web sockets or Ajax to send the record to the server.  After the record is created it will notify all published cursors of its presence.  Note that on the client, it will notify cursors before the Ajax response comes, to make it look as if the record saved immediately.  If the server responds with any errors, it will keep the newly created record in the cursor but set validation errors.

Here is how the record creation process works internally.

First you call the `App.User.create`.  The `create` method gets delegated to a new `Tower.Model.Scope` instance, which then delegates it to a new `Tower.Model.Cursor` instance (this will be optimized in the future, but it is necessary for now to keep the API simple).  In `Tower.Model.Scope#create`, it normalizes the attributes you just passed in and sets the arguments to the `@cursor.data` array, which holds all the records you're just about to create. You can pass in a single hash of attributes, and array of attribute hashes, or a splat of arguments, all followed by a callback.

Then `Tower.Model.Cursor#create` iterates through each of attributes in its `@data` array and builds a model, such as calling `App.User.build(attributes)`.  It then iterates through each of the model instances and calls `model.save`, which goes through the model validation lifecycle (described later).  The model then creates another cursor and passes itself in (again, this will be optimized, but it was necessary to keep the API simple for now), calling the `create` method.  So basically, it's back to where it was, only this time the cursor knows we don't need to call `model.save`.  Instead, the cursors `create` method calls `@store.create`, passing itself in as the first parameter - that is, the `store.create` method takes a cursor.  The reason we do this is to give the store enough context about the database operation we're about to perform, so the store can optimize its actual implementation.

The store then creates the record (say for example we're using the MongoDB store on the server and the Memory store on the client).  When it completes, it will return the newly created records - each with a new `id` property - to the calling cursor.  If you passed in a callback, you will now get the record or array of records in the callback.  Finally, the cursor notifies Tower that a record was created.

When Tower gets notified that a record was created, here's what happens on the client.  First, it iterates through all of the client-side controllers and finds any cursors you've published on them.  It then pushes the record(s) into any of the matching cursors - so if any of those cursors were bound to Ember CollectionViews for example, they would display the new record.

When a record gets created on the server, here's what happens.  First, it iterates through all the connected clients (instances of `Tower.Net.Connection`), which are stored in the `Tower.connections` property.  Then for each connected client, it does a similar thing to what it did on the client: iterates through the controllers, finds the cursors, and tests the record(s) against them.  But instead of _adding_ it to the cursor, it just compiles a final array of records the client is allowed to receive.  Once the records have been collected for a single client, it then sends a push notification to the client (through web sockets or fallbacks) with the newly created records.  Then on the client, it just loads them into the store, pushing them into the matching cursors, etc. (same process).  Effectively, this means "cursors" work the same on the client and server.

## What is the "Cursor"?

Most generally, `Tower.Model.Cursor` is a set of criteria for matching a class of models.  On the client, it also is used as an Array, acting as a collection of models matching its criteria.  Technically you can do the same thing on the server, but by default it won't add records to the cursor on the server because it's unnecessary since no state is maintained on the server.