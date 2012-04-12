# `Tower.Model.Attributes`

Consider a simple class for modeling a user in an application. A user may have a first name, last name, and middle name. We can define these attributes on a user by using the `field` macro funnction.

``` coffeescript
class App.User extends Tower.Model
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

If you decide not to specify the field `type`, Tower.js will treat it as a JavaScript `Object` and will try not typecast it when sending the values to the data store.  This means that by default you can easily store things like arbitrary JavaScript objects in MongoDB without worrying about it.

## Getting and Setting Field Values

When a field is defined, Tower provides several different ways of accessing the field.

``` coffeescript
# Get the value of the first name field.
user.get("firstName")
user.firstName # if get/set support is available

# Set the value for the first name field.
user.set("firstName", "Jean")
user.firstName = "Jean" # if get/set support is available
```

In cases where you want to set multiple field values at once, there are a few different ways of handling this as well.

``` coffeescript
# Get the field values as a hash.
user.attributes

# Set the field values in the document.
User.new(firstName: "Jean-Baptiste", middleName: "Emmanuel")
user.attributes = { firstName: "Jean-Baptiste", middleName: "Emmanuel" }
```

### Notes on attribute event dispatching

Unlike frameworks such as Spine.js and Backbone.js, changing an attribute's value does not dispatch an event.  Tower.js does not come stocked with event dispatching, for many reasons (more on this later).  There is a simple module `Tower.Model.Events` which you can include in the base model which will add event dispatching.  For simple apps, you don't need event dispatching using the Controller model from Rails that Tower.js implements.  For complex apps that need data-binding, client-side frameworks like Ember.js, Knockout.js, and Angular.js complement Tower.js perfectly and can definitely be used with it.

## Defaults

You can tell a field in Tower to always have a default value if nothing has been provided. Defaults are either static values or callback functions.

``` coffeescript
class App.User extends Tower.Model
  @field "bloodAlcoholLevel", type: "Float", default: 0.40
  @field "lastLogin", type: "Time", default: -> 10.minutes.ago
```

Be wary that default values that are not defined as functions are evaluated at class load time, so the following 2 definitions are not equivalent. (You probably would prefer the second, which is at document creation time.)

``` coffeescript
class App.User extends Tower.Model
  @field "dob", type: "Time", default: Time.now
  @field "dob", type: "Time", default: -> Time.now
```

If you want to set a default with a dependency on the document's state, `this` inside a callback evaluates to the document instance.

``` coffeescript
class App.User extends Tower.Model
  @field "joinedAt", type: "Time", default: -> if @isNew() then 2.hours.ago else Time.now
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

Note: This is very similar to how you would define custom fields in _Mongoid_ (MongoDB mapper for Rails)

## Reserved Names

If you define a field on your document that conflicts with a reserved method name in Tower, the configuration will raise an error. For a list of these you may look at `Tower.destructiveFields`.
