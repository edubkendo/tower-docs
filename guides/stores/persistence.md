# Persistence

Each `Tower.Store` method requires exact parameters (there's no argument overloading).

The store is used by the `Tower.Model` internally.

- `Store#find`
- `Store#create`
- `Store#update`
- `Store#destroy`

## `Store#find`

Returns an array of models.  The database is free to perform more fine-grained optimizations, such as making a `collection.findOne` call in mongodb if there's only one `id` we're searching by.

``` coffeescript
store.find { "id" : { "$in": [1, 2, 3] } }
store.find { "id" : { "$nin": [1, 2, 3] } }
store.find { "tags" : { "$all": ["ruby", "javascript"] } }
store.find { "tags" : { "$in": ["ruby", "javascript"] } }
store.find { "$or": [ { "tags" : { "$in": ["ruby", "javascript"] } }, { "id" : { "$in": [1, 2, 3] } } ] }
```

## `Store#create`

Creates one model.

``` coffeescript
store.create { "tags" : ["ruby", "javascript"] }
```

## `Store#update`

Updates any models matching the query.

``` coffeescript
store.update { "$set": { "tags" : ["ruby", "javascript"] } }, { "id" : { "$in": [1, 2, 3] } }
```

## `Store#destroy`

Deletes any models matching the query.

``` coffeescript
store.destroy { "id" : { "$in": [1, 2, 3] } }
```
