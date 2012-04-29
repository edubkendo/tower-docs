# Persistence

Each `Tower.Store` method requires exact parameters (there's no argument overloading).

The store is used by the `Tower.Model` internally.

- `Store#create`
- `Store#update`
- `Store#destroy`

## `Tower.Store#create`

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
