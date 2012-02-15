# Querying

The following are a list of chainable query methods in Tower.js.  Shown alongside each example are the generated query parameters and options which are passed to the `store` object.  The stores then convert these normalized criteria into the datastore-specific format.

Please note that criteria are lazy evaluated, and with each chained method it will be cloned and return a new criteria copy.

## Query Methods

- `Model.allIn`
- `Model.allOf`
- `Model.alsoIn`
- `Model.anyIn`
- `Model.anyOf`
- `Model.asc`
- `Model.desc`
- `Model.distinct`
- `Model.excludes`
- `Model.includes`
- `Model.limit`
- `Model.near`
- `Model.notIn`
- `Model.only`
- `Model.order`
- `Model.paginate`
- `Model.offset`
- `Model.where`
- `Model.without`

## `Model.allIn`

Adds a criterion that specifies values that must all match in order to return results.

### Model

``` coffeescript
# Match all people with Bond and 007 as aliases.
User.allIn(aliases: ["Bond", "007"])
```

### Criteria

``` coffeescript
{ "aliases" : { "$all" : [ "Bond", "007" ] }}
```

## `Model.allOf`

Adds a criterion that specifies expressions that must all match in order to return results.

### Model

``` coffeescript
# Match all crazy old people.
User.allOf(age: {">=": 60 }, mentalState: "crazy mofos")
```

### Criteria

``` coffeescript
{ "$and" : [{ "age" : { "$gt" : 60 }}, { "mentalState" : "crazy mofos" }] }
```

## `Model.alsoIn`

Adds a criterion that specifies values where any value can be matched in order to return results. This is similar to Criteria#anyIn with the exception here that if if it chained with values for the same field it performs a union of the values where anyIn perform an intersection.

### Model

``` coffeescript
# Match all people with either Bond or 007 as aliases.
User.alsoIn(aliases: [ "Bond", "007" ])
User.anyIn(aliases: [ "Bond" ]).alsoIn(aliases: [ "007" ])
```

### Criteria

``` coffeescript
{ "aliases" : { "$in" : [ "Bond", "007" ] }}
```

## `Model.anyIn`

Adds a criterion that specifies values where any value can be matched in order to return results. This is similar to Criteria#alsoIn with the exception here that if if it chained with values for the same field it performs an intersection of the values where alsoIn perform a union.

### Model

``` coffeescript
# Match all people with either Bond or 007 as aliases.
User.anyIn(aliases: [ "Bond", "007" ])
User
  .anyIn(aliases: [ "Bond", "007", "James" ])
  .anyIn(aliases: [ "Bond", "007" ])
```

### Criteria

``` coffeescript
{ "aliases" : { "$in" : [ "Bond", "007" ] }}
```

## `Model.anyOf`

Adds a criterion that specifies a set of expressions that any can match in order to return results. The underlying MongoDB expression is $or.

### Model

``` coffeescript
# Match all people with either last name Penn or Teller
User.anyOf({ lastName: "Penn" }, { lastName: "Teller" })
```

### Criteria

``` coffeescript
{ "lastName" :
  { "$or" :
    [ { "lastName" : "Penn" }, { "lastName" : "Teller" } ]
  }
}
```

## `Model.asc`

Adds ascending sort options for the provided fields.

### Model

``` coffeescript
# Sort people by first and last name ascending.
User.asc("firstName", "lastName")
```

### Criteria

``` coffeescript
{ "sort" :
    {[ [ "firstName", "asc" ],
      [ "lastName", "asc" ] ]} }
```

## `Model.desc`

Adds descending sort options for the provided fields.

### Model

``` coffeescript
# Sort people by first and last name descending.
User.desc("firstName", "lastName")
```

### Criteria

``` coffeescript
{ "sort" :
    {[ [ "firstName", "desc" ],
      [ "lastName", "desc" ] ]} }
```

## `Model.distinct(name)`

Get the distinct values for the provided field.

### Model

``` coffeescript
# Get the distinct values for last names
User.distinct("lastName")
```

### Criteria

``` coffeescript
{ "distinct" : "lastName" }
```

## `Model.excludes`

Adds a criterion that specifies a set of expressions that cannot match in order to return results. The underlying MongoDB expression is $ne.

### Model

``` coffeescript
# Match all people without either last name Teller and first name Bob.
User.excludes(lastName: "Teller", firstName: "Bob")
```

### Criteria

``` coffeescript
{{ "lastName" : { "$ne" : "Teller" } }, { "firstName" : { "$ne" : "Bob" } }}
```

## `Model.includes`

Adds a criterion that specifies a list of relational associations to eager load when executing the query. This is to prevent the n+1 issue when iterating over documents that access their relations during the iteration.

This only works with `hasMany`, `hasOne`, and `belongsTo` relations and only 1 level deep at the current moment. If you try to eager load a many to many an exception will get raised. Many to many is not supported due to the performance actually being slower despite lowering the number of datastore calls.

### Model

``` coffeescript
# Eager load the posts and games when retrieving the people.
User.includes("posts", "comments")
```

### Criteria

``` coffeescript
peopleIds = people.find({}, { "fields" : { "_id" : 1 }})
posts.find({ "personId" : { "$in" : peopleIds }})
comments.find({ "personId" : { "$in" : peopleIds }})
```

## `Model.limit`

Limits the number of returned results by the provided value.

### Model

``` coffeescript
# Only return 20 documents.
User.limit(20)
```

### Criteria

``` coffeescript
{ "limit" : 20 }
```

## `Model.near`

Adds a criterion to find locations that are near the supplied coordinates. This performs a MongoDB $near selection and requires a 2d index to be on the provided field.

### Model

``` coffeescript
# Match all bars near Berlin
Bar.near(location: [ 52.30, 13.25 ])
```

### Criteria

``` coffeescript
{ "location" : { "$near" : [ 52.30, 13.25 ] }}
```

## `Model.notIn`

Adds a criterion that specifies a set of expressions that cannot match in order to return results. The underlying MongoDB expression is $nin.

### Model

``` coffeescript
# Match all people without last names Zorg and Dallas
User.notIn(lastName: [ "Zorg", "Dallas" ])
```

### Criteria

``` coffeescript
{{ "lastName" : { "$nin" : [ "Zorg", "Dallas" ] } }}
```

## `Model.only`

Limits the fields returned from the datastore to those supplied to the method. Extremely useful for list views where the entire documents are not needed. Cannot be used in conjunction with `#without`.

### Model

``` coffeescript
# Return only the first and last names of each person.
User.only("firstName", "lastName")
```

### Criteria

``` coffeescript
options: { "fields" : { "firstName" : 1, "lastName" : 1 }}
```

## `Model.order`

Sorts the results given the arguments that must match the MongoDB driver sorting syntax (key/value pairs of field and direction).

### Model

``` coffeescript
# Provide the sorting options.
User.order("firstName", "asc").order("lastName", "desc")
```

### Criteria

``` coffeescript
{ "sort" :
    {[ [ "firstName", "asc" ],
      [ "lastName", "desc" ] ]} }
```

## `Model.skip`

Skips the number of the results given the provided value, similar to a SQL "offset".

### Model

``` coffeescript
# Skip 20 documents.
User.skip(20)
```

### Criteria

``` coffeescript
{ "skip" : 20 }
```

## `Model.where`

Adds a criterion that must match in order to return results. If provided a string it interperets it as a javascript function and converts it to the proper $where clause. Tower also provides convenience h4s on Symbol to make advanced queries simpler to write.

### Model

``` coffeescript
# Match all people with first name Emmanuel
User.where(firstName: "Emmanuel")

# Match all people who live in Berlin, where address is embedded.
User.where("addresses.city": "Berlin")

# Same as above but with a hash.
User.where(addresses: city: "Berlin")

# Match all people who live at an address in Berlin or
# Munich where address is embedded.
User.where("addresses.city": {"$in": ["Berlin", "Munich"]})

# Example complex queries
User.where(age: ">": 21)
User.where(age: $gt: 21)
User.where(age: ">=": 21)
User.where(age: $gte: 21)
User.where(title: $in: ["Sir", "Madam"])
User.where(age: "<": 55)
User.where(age: $lt: 55)
User.where(age: "<=": 55)
User.where(age: $lte: 55)
User.where(title: $ne: "Mr")
User.where(title: $nin: ["Esquire"])
User.where(age: ">=": 18, "<=": 55)
```

### Criteria

``` coffeescript
# Match all people with first name Emmanuel
{ "firstName" : "Emmanuel" }

# Match all people who live in Berlin, where address is embedded.
{ "addresses.city" : "Berlin" }

# Example queries using symbol h4s to perform more complex criteria.
{ "age" : { "$gt" : 18 }}
{ "age" : { "$gt" : 18 }}
{ "age" : { "$gte" : 18 }}
{ "age" : { "$gte" : 18 }}
{ "title" : { "$in" : [ "Sir", "Madam" ] }}
{ "age" : { "$lt" : 55 }}
{ "age" : { "$lt" : 55 }}
{ "age" : { "$lte" : 55 }}
{ "age" : { "$lte" : 55 }}
{ "title" : { "$ne" : "Mr" }}
{ "title" : { "$nin" : [ "Esquire" ] }}
{ "age" : { "$gte" : 18, "$lte" : 55 }}
```

## `Model.without`

Limits the fields returned from the datastore to those NOT supplied to the method. Extremely useful for list views where the entire documents are not needed. Cannot be used in conjunction with `#only`.

### Model

``` coffeescript
# Return all fields except first name and last name
User.without("firstName", "lastName")
```

### Criteria

``` coffeescript
{ "fields" : { "firstName" : 0, "lastName" : 0 }}
```

# Scopes

- `Model.where`
- `Model.order`
- `Model.asc`
- `Model.desc`
- `Model.page`
- `Model.limit`

## `Model.scope`

# Create named scope class method finders for a model.
#
# @example Add scope to a User model
# 
#     class User
#       @scope "active",      @where(active: true)
#       @scope "recent",      @where(createdAt: ">=": 2.days().ago()).order("createdAt", "desc").order("email", "asc")
#       @scope "developers",  @where(tags: _anyIn: ["ruby", "javascript"])
# 

# ## Examples
# 
#     # delete users 1, 2, and 3
#     User.delete 1, 2, 3, (error, records)
#     User.delete [1, 2, 3], (error, records)
#     User.delete [1, 2, 3], (error)
#     User.delete 1, 2, 3, {instantiate: false, validate: false}, (error)
#     User.delete {instantiate: false, validate: false}, (error)
#

# ## Examples
#
#     User.update 1, 2, 3, name: "John", (error, records)
#     User.update 1, 2, 3, name: "John", (error)
#     User.update [1, 2, 3], name: "John", (error, records)
#     User.update [1, 2, 3], name: "John", (error)
#     User.update name: "John", (error, records)
#     User.update name: "John", (error)
#     User.update 1, 2, 3, {name: "John"}, {instantiate: false, validate: false}, (error)
#     User.update {name: "John"}, {instantiate: false, validate: false}, (error)
#

# ## Examples
#
#     User.create name: "John", (error, record)
#

# find(1)
# find(1, 2, 3)


# @param only
# @param include
# @param except
# @param methods
# 
#     @user.toJSON
#       include:
#         posts:
#           include:
#             taggings:
#               include:
#                 tag:
#                   only: "name"

``` coffeescript
User.where(createdAt: ">=": 2.days().ago()).paginate(page: 10, limit: 20).all()
```

## Notes

- https://github.com/visionmedia/dm-pagination

``` html
<div class="pager">
  <a href="/items?page=1" class="first">First</a>
  <a href="/items?page=1" class="previous">Previous</a>
  <ul>
    <li class="page-1 first"><a href="/items?page=1" class="">1</a></li>
    <li class="active page-2"><a href="/items?page=2" class="">2</a></li>
    <li class="page-3 last"><a href="/items?page=3" class="">3</a></li>
    <li class="more">...</li>
  </ul>
  <a href="/items?page=3" class="next">Next</a>
  <a href="/items?page=5" class="last">Last</a>
</div>
```