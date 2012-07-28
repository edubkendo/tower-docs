# Validations

## The Errors Object

## Validation Helpers

Tower offers many pre-defined validation helpers that you can use directly inside your model class App.definitions. These helpers provide common validation rules. Every time a validation fails, an error message is added to the object's errors collection, and this message is associated with the field being validated.

Each helper accepts an arbitrary number of attribute names, so with a single line of code you can add the same kind of validation to several attributes.

All of them accept the `on` and `message` options, which define when the validation should be run and what message should be added to the errors collection if it fails, respectively. The `on` option takes one of the values `save` (the default), `create` or `update`. There is a default error message for each one of the validation helpers. These messages are used when the `message` option isn't specified. Let's take a look at each one of the available helpers.

### Acceptance

Validates that a checkbox on the user interface was checked when a form was submitted. This is typically used when the user needs to agree to your application's terms of service, confirm reading some text, or any similar concept. This validation is very specific to web applications and this 'acceptance' does not need to be recorded anywhere in your database (if you don't have a field for it, the helper will just create a virtual attribute).

``` coffeescript
class App.User extends Tower.Model
  @validates 'termsOfService', acceptance: true
```
  
The default error message for this helper is 'must be accepted'.

It can receive an `accept` option, which determines the value that will be considered acceptance. It defaults to '1' and can be easily changed.

``` coffeescript
class App.User extends Tower.Model
  validates 'termsOfService', acceptance: { accept: 'yes' }
```

### Associated

You should use this helper when your model has associations with other models and they also need to be validated. When you try to save your object, valid? will be called upon each one of the associated objects.

``` coffeescript
class App.Library extends Tower.Model
  @hasMany 'books'
  
  @validates associated: 'books'
```

This validation will work with all of the association types.

Don't use validatesAssociated on both ends of your associations. They would call each other in an infinite loop.

The default error message for validatesAssociated is 'is invalid'. Note that each associated object will contain its own errors collection; errors do not bubble up to the calling model.

### Confirmation

You should use this helper when you have two text fields that should receive exactly the same content. For example, you may want to confirm an email address or a password. This validation creates a virtual attribute whose name is the name of the field that has to be confirmed with '_confirmation' appended.

``` coffeescript
class App.User extends Tower.Model
  @validates 'email', confirmation: true
```

This check is performed only if emailConfirmation is not nil. To require confirmation, make sure to add a presence check for the confirmation attribute (we'll take a look at presence later on this guide):

``` coffeescript
class App.User extends Tower.Model
  @validates 'email', confirmation: true
  @validates 'emailConfirmation', presence: true
```

The default error message for this helper is 'doesn't match confirmation'.

### Exclusion

This helper validates that the attributes' values are not included in a given set. In fact, this set can be any enumerable object.

``` coffeescript
class App.Account extends Tower.Model
  @validates 'subdomain', exclusion: { in: ['www', 'us', 'ca', 'jp'], message: 'Subdomain %{value} is reserved.' }
```

The exclusion helper has an option `in` that receives the set of values that will not be accepted for the validated attributes. The `in` option has an alias called `within` that you can use for the same purpose, if you'd like to. This example uses the `message` option to show how you can include the attribute's value.

The default error message is 'is reserved'.

### Format

This helper validates the attributes' values by testing whether they match a given regular expression, which is specified using the `with` option.

``` coffeescript
class App.Product extends Tower.Model
  @validates 'legacyCode', format: { with: /\A[a-zA-Z]+\z/, message: 'Only letters allowed' }
```

The default error message is 'is invalid'.

### Inclusion

This helper validates that the attributes' values are included in a given set. In fact, this set can be any enumerable object.

``` coffeescript
class App.Coffee extends Tower.Model
  @validates 'size', inclusion: { in: ['small', 'medium', 'large'], message: '%{value} is not a valid size' }
```

The inclusion helper has an option `in` that receives the set of values that will be accepted. The `in` option has an alias called `within` that you can use for the same purpose, if you'd like to. The previous example uses the `message` option to show how you can include the attribute's value.

The default error message for this helper is 'is not included in the list'.

### Length

This helper validates the length of the attributes' values. It provides a variety of options, so you can specify length constraints in different ways:

``` coffeescript
class App.User extends Tower.Model
  @validates 'name', length: { minimum: 2 }
  @validates 'bio', length: { maximum: 500 }
  @validates 'password', length: { in: 6..20 }
  @validates 'registrationNumber', length: 6
```

The possible length constraint options are:

`minimum` – The attribute cannot have less than the specified length.
`maximum` – The attribute cannot have more than the specified length.
`in` (or `within`) – The attribute length must be included in a given interval. The value for this option must be a range.
`is` – The attribute length must be equal to the given value.
The default error messages depend on the type of length validation being performed. You can personalize these messages using the `wrongLength`, `tooLong`, and `tooShort` options and %{count} as a placeholder for the number corresponding to the length constraint being used. You can still use the `message` option to specify an error message.

``` coffeescript
class App.User extends Tower.Model
  @validates 'bio', length: { maximum: 1000, tooLong: '%{count} characters is the maximum allowed' }
```

This helper counts characters by default, but you can split the value in a different way using the `tokenizer` option:

``` coffeescript
class App.Essay extends Tower.Model
  @validates 'content', length:
    minimum:   300,
    maximum:   400,
    tooShort:  'must have at least %{count} words',
    tooLong:   'must have at most %{count} words'
```

Note that the default error messages are plural (e.g., 'is too short (minimum is %{count} characters)'). For this reason, when `minimum` is 1 you should provide a personalized message or use validatesPresenceOf instead. When `in` or `within` have a lower limit of 1, you should either provide a personalized message or call presence prior to length.

The size helper is an alias for length.

### Numericality

This helper validates that your attributes have only numeric values. By default, it will match an optional sign followed by an integral or floating point number. To specify that only integral numbers are allowed set `onlyInteger` to true.

If you set `onlyInteger` to true, then it will use the

``` coffeescript
/\A[+-]?\d+\Z/
```

regular expression to validate the attribute's value. Otherwise, it will try to convert the value to a number using Float.

Note that the regular expression above allows a trailing newline character.

``` coffeescript
class App.Player extends Tower.Model
  @validates 'points', numericality: true
  @validates 'gamesPlayed', numericality: { onlyInteger: true }
```

Besides `onlyInteger`, this helper also accepts the following options to add constraints to acceptable values:

`greaterThan` – Specifies the value must be greater than the supplied value. The default error message for this option is 'must be greater than %{count}'.
`greaterThanOrEqualTo` – Specifies the value must be greater than or equal to the supplied value. The default error message for this option is 'must be greater than or equal to %{count}'.
`equalTo` – Specifies the value must be equal to the supplied value. The default error message for this option is 'must be equal to %{count}'.
`lessThan` – Specifies the value must be less than the supplied value. The default error message for this option is 'must be less than %{count}'.
`lessThanOrEqualTo` – Specifies the value must be less than or equal the supplied value. The default error message for this option is 'must be less than or equal to %{count}'.
`odd` – Specifies the value must be an odd number if set to true. The default error message for this option is 'must be odd'.
`even` – Specifies the value must be an even number if set to true. The default error message for this option is 'must be even'.
The default error message is 'is not a number'.

### Presence

This helper validates that the specified attributes are not empty. It uses the blank? method to check if the value is either nil or a blank string, that is, a string that is either empty or consists of whitespace.

``` coffeescript
class App.User extends Tower.Model
  @validates 'name', 'login', 'email', presence: true
```

If you want to be sure that an association is present, you'll need to test whether the foreign key used to map the association is present, and not the associated object itself.

``` coffeescript
class App.LineItem extends Tower.Model
  @belongsTo 'order'

  @validates 'orderId', presence: true
```

Since false.blank? is true, if you want to validate the presence of a boolean field you should use validates `fieldName`, `inclusion: { in: [true, false] }`.

The default error message is 'can't be empty'.

### Uniqueness

This helper validates that the attribute's value is unique right before the object gets saved. It does not create a uniqueness constraint in the database, so it may happen that two different database connections create two records with the same value for a column that you intend to be unique. To avoid that, you must create a unique index in your database.

``` coffeescript
class App.Account extends Tower.Model
  @validates 'email', uniqueness: true
```

The validation happens by performing an SQL query into the model's table, searching for an existing record with the same value in that attribute.

There is a `scope` option that you can use to specify other attributes that are used to limit the uniqueness check:

``` coffeescript
class App.Holiday extends Tower.Model
  validates 'name', uniqueness: { scope: 'year', message: 'should happen once per year' }
```

There is also a `caseSensitive` option that you can use to define whether the uniqueness constraint will be case sensitive or not. This option defaults to true.

``` coffeescript
class App.User extends Tower.Model
  @validates 'name', uniqueness: { caseSensitive: false }
```

Note that some databases are configured to perform case-insensitive searches anyway.

The default error message is 'has already been taken'.
