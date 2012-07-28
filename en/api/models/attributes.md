# `Tower.Model.Attributes`

Consider a simple class for modeling a user in an application. A user may have a first name, last name, and middle name. We can define these attributes on a user by using the `field` macro function.

``` coffeescript
class App.User extends Tower.Model
  @field 'firstName', type: 'String'
  @field 'middleName', type: 'String'
  @field 'lastName', type: 'String'
```

Below is a list of valid types for fields.

- Array
- [todo] BigDecimal (Stores as a String in the database)
- Boolean
- Float
- Object
- Integer
- String
- Time
- Date
- DateTime

If you decide not to specify the field `type`, Tower.js will treat it as a JavaScript `String`.  If you don't want Tower to try typecasting your value, type it to `Object`.

## Getting and Setting Field Values

When a field is defined, Tower provides several different ways of accessing the field.

``` coffeescript
# Get the value of the first name field.
user.get('firstName')
user.firstName # if get/set support is available and Tower.accessors == true

# Set the value for the first name field.
user.set('firstName', 'Jean')
user.firstName = 'Jean' # if get/set support is available
```

In cases where you want to set multiple field values at once, there are a few different ways of handling this as well.

``` coffeescript
User.new(firstName: 'Jean-Baptiste', middleName: 'Emmanuel')

# Get the field values as a hash.
user.getProperties('firstName', 'middleName')
#=> { firstName: 'Jean-Baptiste', middleName: 'Emmanuel' }

# Set the field values in the record.
user.setProperties(firstName: 'Jean-Baptiste', middleName: 'Emmanuel')
```

This is straight from Ember.js.  It wraps all `set` calls in a single operation.

## Defaults

You can tell a field in Tower to always have a default value if nothing has been provided. Defaults are either static values or callback functions.

``` coffeescript
class App.User extends Tower.Model
  @field 'bloodAlcoholLevel', type: 'Float', default: 0.40
  @field 'lastLogin', type: 'Time', default: -> 10.minutes.ago
```

Be wary that default values that are not defined as functions are evaluated at class load time, so the following 2 definitions are not equivalent. (You probably would prefer the second, which is at record creation time.)

``` coffeescript
class App.User extends Tower.Model
  @field 'dob', type: 'Time', default: new Date
  @field 'dob', type: 'Time', default: -> new Date
```

If you want to set a default with a dependency on the record's state, `this` inside a callback evaluates to the record instance.

``` coffeescript
class App.User extends Tower.Model
  @field 'joinedAt', type: 'Time', default: -> if @isNew() then _(2).hours().ago() else new Date
```

## Custom Field Serialization

You can define custom types in Tower and determine how they are serialized and deserialized. You simply need to define the class, include Tower.Model.Attributes.Serializable, and override the serialize and deserialize methods as needed. Deserialization is used to convert from the value that is stored in the database to a value that is used when accessed. Serialization is used to convert the object to a MongoDB friendly value.

``` coffeescript
class Profile extends Tower.Model
  @field location, type: 'Point'

class App.Point
  @include Tower.Model.Attributes.Serializable
  
  decode: (object) ->
    [ object['x'], object['y'] ]

  encode: (object) ->
    { 'x' : object[0], 'y' : object[1] }
```

Note: This is very similar to how you would define custom fields in _Mongoid_ (MongoDB mapper for Rails).

## Reserved Names

If you define a field on your record that conflicts with a reserved method name in Tower, the configuration will raise an error. For a list of these you may look at `Tower.Model.destructiveFields`.
