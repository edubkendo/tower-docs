# Querying

## Operators

### `$eq`

``` coffeescript
store.find { "status" : "active" }
store.find { "status" : "$eq" : "active" }
```

### `$ne`

``` coffeescript
store.find { "status" : "$ne" : "inactive" }
```

### `<, <=, >, >=`

``` coffeescript
store.find { "likeCount" : ">=" : 10 }
store.find { "likeCount" : "$gte" : 10 }
```

### `$all`

``` coffeescript
store.find { "tags" : { "$all" : ["ruby", "javascript"] } }
```

### `$in`

``` coffeescript
store.find { "tags" : { "$in" : ["ruby", "javascript"] } }
```

### `$nin`

``` coffeescript
store.find { "tags" : { "$nin" : ["java", "asp"] } }
```

### `$match`

``` coffeescript
store.find { "name" : /acme.*corp/i }
```

### `$notMatch`

``` coffeescript
store.find { "name" : /acme.*corp/i }
```

### `$or`

``` coffeescript
store.find { "$or": [ { "likeCount" : 1000 }, { "likeCount" : { "$gte": 1, "$lte": 100 } } ] }
```

### `$nor`

``` coffeescript
store.find { "$nor": [ { "likeCount" : 1000 }, { "likeCount" : { "$gte": 1, "$lte": 100 } } ] }
```

### `$and`

``` coffeescript
store.find { "$and" : [ { "a" : 1 }, { "a" : { $gt: 5 } } ] }
```

## Sorting

### `sort`

``` coffeescript
store.find { "tags" : { "$in" : ["ruby", "javascript"] }, "sort": [["title", "asc"]] }
```

## Paginating

### `limit`

``` coffeescript
store.find { "tags" : { "$in" : ["ruby", "javascript"] }, "limit": 20 }
```

### `offset`

``` coffeescript
store.find { "tags" : { "$in" : ["ruby", "javascript"] }, "offset": 10 }
```

## Selecting Specific Fields

### `fields`