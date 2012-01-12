# Params

You can define parameters which should be parsed into a `Tower.Model.Criteria`.  This allows you to build a very robust query api with minimal effort.

Tower uses a set of pseudo-ruby conventions for defining ranges and sets of values to query by.  They are defined with the `@param` class method on a controller.  Tower looks for the attribute definition on the model class associated with the controller, unless you have specified the `type` option.

``` coffeescript
class App.EventsController extends Tower.Controller
  @param "title"
  @param "createdAt"
  @param "memberCount"
  @param "tags", type: "Array"
  @param "coordinates"
  
  index: ->
    App.Event.where(@criteria()).all (error, events) =>
      @render json: events
```

- `String`
- `Date`
- `Array`
- `Number`
- `Order`
- `Coordinates`

## `String`

### Query

``` coffeescript
title=Hello+World
title=Hello+-World
title='Hello+World'
```

### Criteria

``` coffeescript
{ "title" : { "$match" : ["Hello", "World"] } }
{ "title" : { "$match" : ["Hello"], "$notMatch" : ["World"] } }
{ "title" : { "$match" : ["Hello World"] } }
```

## `Date`

### Query

``` coffeescript
createdAt=12-31-2011
createdAt=12-31-2011..t
createdAt=t..12-31-2011
createdAt=12-21-2011..12-31-2011
createdAt=12-21-2011..12-31-2011,01-04-2012
```

### Criteria

``` coffeescript
{ "createdAt" : Date(12-31-2011) }
{ "createdAt" : { "$gte": Date(12-31-2011) } }
{ "createdAt" : { "$lte": Date(12-31-2011) } }
{ "createdAt" : { "$gte": Date(12-21-2011), "$lte": Date(12-31-2011) } }
{ "$or": [ { "createdAt" : { "$gte": Date(12-21-2011), "$lte": Date(12-31-2011) } }, { "createdAt" : Date(01-04-2012) } ] }
```

## `Number`

### Query

``` coffeescript
likeCount=1
likeCount=1..n
likeCount=n..100
likeCount=1..100
likeCount=1..100,1000
likeCount=-10
likeCount=^10
likeCount=^10,1000
likeCount=^10..1000
likeCount=^-1000
```

### Criteria

``` coffeescript
{ "likeCount" : 1 }
{ "likeCount" : { "$gte": 1 } }
{ "likeCount" : { "$lte": 1 } }
{ "likeCount" : { "$gte": 1, "$lte": 100 } }
{ "$or": [{ "likeCount" : { "$gte": 1, "$lte": 100 } }, { "likeCount" : 1000 }] }
{ "likeCount": -10 }
{ "likeCount": { "$neq": -10 } }
{ "likeCount": { "$neq": 10, "$in": [1000] } }
{ "nor": [ { "likeCount" : { "$gte": 10, "$lte": 1000 } } ] }
{ "likeCount": { "$neq": -1000 } }
```

## `Array`

### Query

``` coffeescript
tags=javascript
tags=^java
tags=ruby,^java
tags=[ruby,javascript]
```

### Criteria

``` coffeescript
{ "tags" : { "$in": ["javascript"] } }
{ "tags" : { "$nin": ["java"] } }
{ "tags" : { "$in": ["ruby"], "$nin": ["java"] } }
{ "tags" : { "$all": ["ruby", "javascript"] } }
```

## `Coordinates`

### Query

``` coffeescript
coordinates=51.509981,-0.074704
coordinates=51.509981,-0.074704,10
```

### Criteria

``` coffeescript
{ "coordinates" : { "$near": [51.509981, -0.074704] } }
{ "coordinates" : { "$near": [51.509981, -0.074704] , "$maxDistance" : 10 } }
```

## `Order`

### Query

``` coffeescript
sort=title
sort=title+
sort=title-
sort=createdAt-,title
sort=createdAt+,title+
```

### Criteria

``` coffeescript
{ "sort" : [["title", "asc"]] }
{ "sort" : [["title", "asc"]] }
{ "sort" : [["title", "desc"]] }
{ "sort" : [["createdAt", "desc"], ["title", "asc"]] }
{ "sort" : [["createdAt", "asc"], ["title", "asc"]] }
```

## Examples

``` coffeescript
http://events.towerjs.org/?createdAt=12-25-2011
http://events.towerjs.org/?createdAt=12-25-2011..12-31-2011
http://events.towerjs.org/?tags=javascript,ruby
http://events.towerjs.org/?memberCount=10..n
http://events.towerjs.org/?sort=createdAt-,title+
http://events.towerjs.org/?createdAt=12-25-2011..12-31-2011&tags=javascript,ruby
http://events.towerjs.org/?createdAt=12-25-2011..12-31-2011&tags=javascript,ruby&sort=createdAt-,title+
http://events.towerjs.org/?createdAt=12-25-2011..12-31-2011&tags=javascript,ruby&memberCount=10..n&sort=createdAt-,title+
http://events.towerjs.org/?createdAt=12-25-2011..12-31-2011&tags=javascript,ruby&memberCount=10..n&coordinates=51.509981,-0.074704,10&sort=createdAt-,title+
```

The last url above would generate the criteria:

``` coffeescript
{ 
  "coordinates" : { "$near": [51.509981, -0.074704] , "$maxDistance" : 10 },
  "createdAt" : { "$gte": Date(12-21-2011), "$lte": Date(12-31-2011) },
  "memberCount" : { "$gte": 10 },
  "sort" : [["createdAt", "desc"], ["title", "asc"]], 
  "tags" : { "$in": ["ruby", "javascript"] }
}
```

### `OR` Queries Over Several Attributes

You can do `OR` searches over several attributes, i.e. "find all posts in the past 2 days OR those tagged with 'javascript'".  Just prepend each `OR` block with an array index:

``` coffeescript
# find all posts between christmas and new years eve, or those tagged with "javascript" and "ruby", then sort by date and title
[0]createdAt=12-25-2011..12-31-2011&[1]tags=javascript,ruby&sort=createdAt-,title+
createdAt[0]=12-25-2011..12-31-2011&tags[1]=javascript,ruby&sort=createdAt-,title+
```

## Nested