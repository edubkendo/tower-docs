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

# Set the value for the first name field.
user.set('firstName', 'Jean')
```

In cases where you want to set multiple field values at once, there are a few different ways of handling this as well.

``` coffeescript
App.User.new(firstName: 'Jean-Baptiste', middleName: 'Emmanuel')

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
  @field 'lastLogin', type: 'Time', default: -> _(10).minutes().ago().toDate()
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
  @field 'joinedAt', type: 'Time', default: -> if @get('isNew') then _(2).hours().ago() else new Date
```

## Computed Attributes

If attributes are computed from fields, don't make it a field, just use computed properties directly:

``` coffeescript
class App.User extends Tower.Model
  @field 'firstName'
  @field 'lastName'

  name: Ember.computed(->
    "#{@get('firstName')} #{@get('lastName')}".trim()
  ).property('firstName', 'lastName')
```