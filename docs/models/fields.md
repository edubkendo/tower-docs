# Fields

Consider a simple class for modeling a person in an application. A person may have a first name, last name, and middle name. We can define these attributes on a person by using the fields macro.

``` coffeescript
class Person extends Tower.Model
  @field "firstName", type: "String"
  @field "middleName", type: "String"
  @field "lastName", type: "String"
```

Below is a list of valid types for fields.

- Array
- BigDecimal (Stores as a String in the database)
- Boolean
- Date
- DateTime
- Float
- Hash
- Integer
- String
- Time

If you decide not to specify the type of field with the definition, Tower will treat it as an object and not try to typecast it when sending the values to the database. This can be advantageous in 2 places, since the lack of attempted conversion will yield a slight performance gain. However some fields are not supported if not defined as fields. A note of thumb for what fields you can use are:

You're not using a web front end and values are already properly cast.

All of your fields are strings.

``` coffeescript
class Person extends Tower.Model
  @field "firstName"
  @field "middleName"
  @field "lastName"
```

## Getting and Setting Field Values

When a field is defined, Tower provides several different ways of accessing the field.

``` coffeescript
# Get the value of the first name field.
person.firstName # if get/set support is available
person.get("firstName")

# Set the value for the first name field.
person.firstName = "Jean" # if get/set support is available
person.set("firstName", "Jean")
```

In cases where you want to set multiple field values at once, there are a few different ways of handling this as well.

``` coffeescript
# Get the field values as a hash.
person.attributes

# Set the field values in the document.
Person.new(firstName: "Jean-Baptiste", middleName: "Emmanuel")
person.attributes = { firstName: "Jean-Baptiste", middleName: "Emmanuel" }
```

## Defaults

You can tell a field in Tower to always have a default value if nothing has been provided. Defaults are either static values or lambdas.

``` coffeescript
class Person extends Tower.Model
  @field "bloodAlcoholLevel", type: "Float", default: 0.40
  @field "lastDrink", type: "Time", default: -> 10.minutes.ago
```
  
Be wary that default values that are not defined as functions are evaluated at class load time, so the following 2 definitions are not equivalent. (You probably would prefer the second, which is at document creation time.)

``` coffeescript
@field "dob", type: "Time", default: Time.now
@field "dob", type: "Time", default: -> Time.now
```

If you want to set a default with a dependency on the document's state, self inside a lambda or proc evaluates to the document instance.

``` coffeescript
@field "wastedAt", type: "Time", default: -> if @isNew() then 2.hours.ago else Time.now
```

## Custom Field Serialization

You can define custom types in Tower and determine how they are serialized and deserialized. You simply need to define the class, include Tower::Fields::Serializable, and override the serialize and deserialize methods as needed. Deserialization is used to convert from the value that is stored in the database to a value that is used when accessed. Serialization is used to convert the object to a MongoDB friendly value.

``` coffeescript
class Profile extends Tower.Model
  @field location, type: "Point"

class Point
  include Tower::Fields::Serializable

  decode: (object) ->
    [ object["x"], object["y"] ]

  encode: (object) ->
    { "x" : object[0], "y" : object[1] }
```

## Reserved Names

If you define a field on your document that conflicts with a reserved method name in Tower, the configuration will raise an error. For a list of these you may look at `Tower.destructiveFields`.
