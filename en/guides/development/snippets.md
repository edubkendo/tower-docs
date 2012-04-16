# Code Snippets

Quick examples of how to do common things that are too [perhaps] specific to be included in the framework itself.

## Sequential IDs in Mongo

``` coffeescript
class App.Sequence extends Tower.Model
  @field "value", type: "Integer"
  
  # only works in mongodb, refactor later.
  # collection.findAndModify(query, sort, update, options, callback)
  @next: (name, callback) ->
    @store().collection().findAndModify {_id: name}, [['_id','asc']], {"$inc": {value: 1}}, {upsert: true, new: true}, (error, record) =>
      callback.call @, error, try record.value
    
    undefined
```
