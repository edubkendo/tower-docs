# Finders

Here are the methods used to query models in a datastore:

- `Model.all`
- `Model.find`
- `Model.first`
- `Model.last`
- `Model.count`
- `Model.exists`
- `Model.batch`

These methods are delegated to a method of the same name a `Tower.Model.Scope` instance.  By delegating all query and persistence calls to the `Tower.Model.Scope` object, there's one place in the Tower.js code to build out a very powerful API for chainable scopes (more on that later).  This means you can do:

``` coffeescript
User.all()
```

or create a reusable scope:

``` coffeescript
User.where(firstName: /^[aA]/).limit(10).all()
```

By calling one of the finder methods, the scope's criteria are compiled into an optimized query and the models are queried.

## `Model.all`

Returns an array of models.  It only takes one argument, the `callback`.  If you're using the memory store, it will also return an array of models so you don't need to pass in a callback.  This makes TDD much easier.  BUT, don't count on that, as the other stores return sometimes random things.  Use the callback whenever you can.  As usual, the first argument in the callback is an error.

``` coffeescript
User.all (error, models) ->
  for model in models
    console.log model.get("id")
```

## `Model.find`

Provides the ability to find one or many models given a set of ids.  This is a more all-inclusive API than `all`.

The first way to use this method is for finding a single record given the provided `id`. If no record is found this will raise an error unless the configuration option is changed.  You can call this method on a scope as well, so you can find all users with a last name of "Black" who have this `id`.

``` coffeescript
User.find(id)
User.find("4baa56f1230048567300485c")
User.where(lastName: "Black").find(id)
```

You may also find multiple records given the provided array of ids. If a single record is not found the error will get raised.

``` coffeescript
User.find([idOne, idTwo])
User.find(["4baa56f1230048567300485c","4baa56f1230048567300485d"])
User.where(lastName: "Black").find([idOne, idTwo])
```

If multiple ids are passed, you will get an array back. If you only pass 1 id, then you get a record back. The complete signature looks like this:

``` coffeescript
User.find "4baa56f1230048567300485c", (error, record) ->
User.find ["4baa56f1230048567300485c", "4baa56f1230048567300485d"], (error, records) ->
```

## `Model.first`

Find the first record in the datastore given the provided criteria. Will return a record or null if nothing is found and defaults to the natural sorting of records in the datastore. You can provide sort criteria as well if you want to dictate the exact record that would be returned first.

``` coffeescript
User.first (error, record) ->
```

## `Model.last`

Find the last record in the datastore given the provided criteria. Will return a record or null if nothing is found and defaults to to sorting by id in descending order. You may provide sort criteria as well if you want to dictate the exact record that would be returned - Tower will invert the sort criteria you provide.

``` coffeescript
User.last (error, record) ->
```

## `Model.count`

Get the count of records given the provided criteria.

``` coffeescript
User.count (error, count) ->
```

## `Model.exists`

Returns true if any records in the datastore exist given the provided criteria and false if there are none.

``` coffeescript
# Do any records exist in the datastore for the provided conditions?
User.exists (error, exists) ->
```

## `Model.batch` (todo)

This will grab records from the datastore in chunks, to prevent a memory usage explosion if you have a lot of records.

``` coffeescript
User.batch(20).each (user) ->
```
