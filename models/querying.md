The following are a list of chainable query methods in Tower.  Shown alongside each example are the generated query parameters and options which are passed to the `store` object.  The stores then convert these normalized criteria into the database-specific format.

Please note that criteria are lazy evaluated, and with each chained method it will be cloned and return a new criteria copy.

## Query Methods

- `Model.allIn`
- `Model.allOf`
- `Model.alsoIn`
- `Criteria#and`
- `Model.anyIn`
- `Model.anyOf`
- `Model.asc`
- `Model.desc`
- `Criteria#distinct`
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
Person.allIn(aliases: ["Bond", "007"])
```

### Store

``` coffeescript
{ "aliases" : { "$all" : [ "Bond", "007" ] }}
```

## `Model.allOf`

Adds a criterion that specifies expressions that must all match in order to return results.

### Model

``` coffeescript
# Match all crazy old people.
Person.allOf(age: {">=": 60 }, mentalState: "crazy mofos")
```

### Store

``` coffeescript
{ "$and" : [{ "age" : { "$gt" : 60 }}, { "mentalState" : "crazy mofos" }] }
```

## `Model.alsoIn`

Adds a criterion that specifies values where any value can be matched in order to return results. This is similar to Criteria#anyIn with the exception here that if if it chained with values for the same field it performs a union of the values where anyIn perform an intersection.

### Model

``` coffeescript
# Match all people with either Bond or 007 as aliases.
Person.alsoIn(aliases: [ "Bond", "007" ])
Person.anyIn(aliases: [ "Bond" ]).alsoIn(aliases: [ "007" ])
```

### Store

``` coffeescript
{ "aliases" : { "$in" : [ "Bond", "007" ] }}
```

## `Model.anyIn`

Adds a criterion that specifies values where any value can be matched in order to return results. This is similar to Criteria#alsoIn with the exception here that if if it chained with values for the same field it performs an intersection of the values where alsoIn perform a union.

### Model

``` coffeescript
# Match all people with either Bond or 007 as aliases.
Person.anyIn(aliases: [ "Bond", "007" ])
Person
  .anyIn(aliases: [ "Bond", "007", "James" ])
  .anyIn(aliases: [ "Bond", "007" ])
```

### Store
``` coffeescript
{ "aliases" : { "$in" : [ "Bond", "007" ] }}
```

## `Model.anyOf`

Adds a criterion that specifies a set of expressions that any can match in order to return results. The underlying MongoDB expression is $or.

### Model

``` coffeescript
# Match all people with either last name Penn or Teller
Person.anyOf({ lastName: "Penn" }, { lastName: "Teller" })
```

### Store

``` coffeescript
{ "lastName" :
  { "$or" :
    [ { "lastName" : "Penn" }, { "lastName" : "Teller" } ]
  }
}
```

## `Model.asc`

Adds ascending sort options for the provided fields.
MONGOID
# Sort people by first and last name ascending.
Person.asc(:firstName, :lastName)
Person.ascending(:firstName, :lastName)
MONGODB QUERY OPTIONS
{ "sort" :
    {[ [ "firstName", Mongo::ASCENDING ],
      [ "lastName", Mongo::ASCENDING ] ]} }
Model.desc | Criteria#desc

Adds descending sort options for the provided fields.
MONGOID
# Sort people by first and last name descending.
Person.desc(:firstName, :lastName)
Person.descending(:firstName, :lastName)
MONGODB QUERY OPTIONS
{ "sort" :
    {[ [ "firstName", Mongo::DESCENDING ],
      [ "lastName", Mongo::DESCENDING ] ]} }
Criteria#distinct(name)

Get the distinct values for the provided field.
MONGOID
# Get the distinct values for last names
Person.all.distinct(:lastName)
MONGODB QUERY OPTIONS
{ "distinct" : "lastName" }
Model.excludes | Criteria#excludes

Adds a criterion that specifies a set of expressions that cannot match in order to return results. The underlying MongoDB expression is $ne.
MONGOID
# Match all people without either last name Teller and first name Bob.
Person.excludes(lastName: "Teller", firstName: "Bob")
MONGODB QUERY SELECTOR
{{ "lastName" : { "$ne" : "Teller" } }, { "firstName" : { "$ne" : "Bob" } }}
Model.includes | Criteria#includes

Adds a criterion that specifies a list of relational associations to eager load when executing the query. This is to prevent the n+1 issue when iterating over documents that access their relations during the iteration.
This only works with hasMany, hasOne, and belongsTo relations and only 1 level deep at the current moment. If you try to eager load a many to many an exception will get raised. Many to many is not supported due to the performance actually being slower despite lowering the number of database calls.
MONGOID
# Eager load the posts and games when retrieving the people.
Person.includes(:posts, :game)
MONGODB QUERIES
peopleIds = people.find({}, { "fields" : { "_id" : 1 }})
posts.find({ "personId" : { "$in" : peopleIds }})
games.find({ "personId" : { "$in" : peopleIds }})
In order for #includes to work the Tower identity map must be enabled in the mongoid.yml:
identityMapEnabled: true
Model.limit | Criteria#limit

Limits the number of returned results by the provided value.
MONGOID
# Only return 20 documents.
Person.limit(20)
MONGODB QUERY OPTIONS
{ "limit" : 20 }
Model.near | Criteria#near

Adds a criterion to find locations that are near the supplied coordinates. This performs a MongoDB $near selection and requires a 2d index to be on the provided field.
MONGOID
# Match all bars near Berlin
Bar.near(location: [ 52.30, 13.25 ])
MONGODB QUERY SELECTOR
{ "location" : { "$near" : [ 52.30, 13.25 ] }}
Model.notIn | Criteria#notIn

Adds a criterion that specifies a set of expressions that cannot match in order to return results. The underlying MongoDB expression is $nin.
MONGOID
# Match all people without last names Zorg and Dallas
Person.notIn(lastName: [ "Zorg", "Dallas" ])
MONGODB QUERY SELECTOR
{{ "lastName" : { "$nin" : [ "Zorg", "Dallas" ] } }}
Model.only | Criteria#only

Limits the fields returned from the database to those supplied to the method. Extremely useful for list views where the entire documents are not needed. Cannot be used in conjunction with #without.
MONGOID
# Return only the first and last names of each person.
Person.only(:firstName, :lastName)
MONGODB QUERY OPTIONS
{ "fields" : { "firstName" : 1, "lastName" : 1 }}
Model.orderBy | Criteria#orderBy

Sorts the results given the arguments that must match the MongoDB driver sorting syntax (key/value pairs of field and direction).
MONGOID
# Provide the sorting options.
Person.orderBy([[:firstName, :asc], [:lastName, :desc]])
MONGODB QUERY OPTIONS
{ "sort" :
    {[ [ "firstName", Mongo::ASCENDING ],
      [ "lastName", Mongo::DESCENDING ] ]} }
Model.skip | Criteria#skip

Skips the number of the results given the provided value, similar to a SQL "offset".
MONGOID
# Skip 20 documents.
Person.skip(20)
MONGODB QUERY OPTIONS
{ "skip" : 20 }
Model.where | Criteria#where

Adds a criterion that must match in order to return results. If provided a string it interperets it as a javascript function and converts it to the proper $where clause. Tower also provides convenience h4s on Symbol to make advanced queries simpler to write.
MONGOID
# Match all people with first name Emmanuel
Person.where(firstName: "Emmanuel")

# Match all people with first name Emmanuel using Javascript.
Person.where("this.firstName == 'Emmanuel'")

# Match all people who live in Berlin, where address is embedded.
Person.where("addresses.city" => "Berlin")

# Match all people who live at an address in Berlin or
# Munich where address is embedded.
Person.where("addresses.city" => {"$in" => ["Berlin, "Munich"]})

# Example queries using symbol h4s to perform more complex criteria.
Person.where(:title.all => ["Sir"])
Person.where(:age.exists => true)
Person.where(:age.gt => 18)
Person.where(:age.gte => 18)
Person.where(:title.in => ["Sir", "Madam"])
Person.where(:age.lt => 55)
Person.where(:age.lte => 55)
Person.where(:title.ne => "Mr")
Person.where(:title.nin => ["Esquire"])
Person.where(:aliases.size => 2)
Person.where(:location.near => [ 22.50, -21.33 ])
Person.where(:location.within => { "$center" => [ [ 50, -40 ], 1 ] })
Person.where(
  :skills.matches => {:level => "pro", :name => "photographer"}
)
Person.where(age: 18...35)

MONGODB QUERY SELECTORS
# Match all people with first name Emmanuel
{ "firstName" : "Emmanuel" }

# Match all people with first name Emmanuel using Javascript.
{ "$where" : "this.firstName == 'Emmanuel'" }

# Match all people who live in Berlin, where address is embedded.
{ "addresses.city" : "Berlin" }

# Example queries using symbol h4s to perform more complex criteria.
{ "title" : { "$all" : [ "Sir" ] }}
{ "age" : { "$exists" : true }}
{ "age" : { "$gt" : 18 }}
{ "age" : { "$gte" : 18 }}
{ "title" : { "$in" : [ "Sir", "Madam" ] }}
{ "age" : { "$lt" : 55 }}
{ "age" : { "$lte" : 55 }}
{ "title" : { "$ne" : "Mr" }}
{ "title" : { "$nin" : [ "Esquire" ] }}
{ "aliases" : { "$size" : 2 }}
{ "location" : { "$near" : [ 22.50, -21.33 ] }}
{ "location" : { "$within" : { "$center" => [ [ 50, -40 ], 1 ] }}}
{ "skills" :
  { "$elemMatch" : { "level" : "pro", "name" : "photographer" }}
}
{ "age" : { "$gte" : 18, "$lte" : 35 }}
Model.without | Criteria#without

Limits the fields returned from the database to those NOT supplied to the method. Extremely useful for list views where the entire documents are not needed. Cannot be used in conjunction with #only.
MONGOID
# Return all fields except first name and last name
Person.without(:firstName, :lastName)
MONGODB QUERY OPTIONS
{ "fields" : { "firstName" : 0, "lastName" : 0 }}
