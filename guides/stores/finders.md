# Finders

- `Store#find`
- `Store#findOne`
- `Store#count`
- `Store#exists`

## `Store#find`

Returns an array of models.  The database is free to perform more fine-grained optimizations, such as making a `collection.findOne` call in mongodb if there's only one `id` we're searching by.

``` coffeescript
store.find { "id" : { "$in": [1, 2, 3] } }
store.find { "id" : { "$nin": [1, 2, 3] } }
store.find { "tags" : { "$all": ["ruby", "javascript"] } }
store.find { "tags" : { "$in": ["ruby", "javascript"] } }
store.find { "$or": [ { "tags" : { "$in": ["ruby", "javascript"] } }, { "id" : { "$in": [1, 2, 3] } } ] }
```
