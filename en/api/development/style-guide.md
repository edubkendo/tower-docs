# Tower Code Style Guide

## Don't extend core objects

Add to underscore, not to the native object prototypes.

## Use single quotes `'` over double quotes `"`

Single quotes are the preferred convention for defining strings. Only use double quotes when you're using interpolation:

``` coffeescript
# do
staticString  = 'a string'
dynamicString = "url: #{window.location.url}"

# don't
staticString  = "a string"

# can't do b/c single quotes don't allow interpolation.
dynamicString = 'url: #{window.location.url}'
```

## Use interpolation `#{}` instead of addition `+`

``` coffeescript
# this
string = "url: #{window.location.url}"

# not this
string = "url: " + window.location.url
```

## Use triple double quotes `"""` for blocks of text

When you need to write blocks of text, use triple quotes `"""`. You can interpolate values within triple double quotes (as opposed to triple single quotes `'''`):

``` coffeescript
color   = 'red'

styles  = """
body, html
  background: #{color}
"""
```

Be careful though, triple quotes don't preserve indentation at the beginning of the text, so either add it to the end of the line, or escape it with backslashes `\ `.

## Start new sentences with a single space, not a double space :)

I guess this is better from a typography standpoint.

## Don't pollute the global namespace

## Avoid CoffeeScript Keywords

- Don't use any "JS_KEYWORDS" words that CoffeeScript allows you to use, because even though you can do `user.delete()` in CoffeeScript, you'd have to write `user["delete"]()` in JavaScript.  These words are:

``` coffeescript
true
false
null
this
new
delete
typeof
in
instanceof
return
throw
break
continue
debugger
if
else
switch
for
while
do
try
catch
finally
class
extends
super
```

## Use `camelCase`, not `snake_case`

## Keep consistent line breaks

- Maximum of 1 blank line between chunks of code.
- First line of indented code should not have a blank line above it in most cases.

Do this:

``` coffeescript
class App.User extends Tower.Model
  @field "email"
  
  @hasMany "posts"
  @hasMany "comments"
  
  activate: (callback) ->
    @updateAttributes activatedAt: new Date, callback
```

Not this:

``` coffeescript
class App.User extends Tower.Model

  @field "email"
  
  @hasMany "posts"
  
  @hasMany "comments"
  
  
  
  activate: (callback) ->
    @updateAttributes activatedAt: new Date, callback
```

## Don't abbreviate method names

- Use the full word for the method name (`width` instead of `w`)
- Only use abbreviations if the abbreviation is the preferred way of expressing the term in the industry.  But even then, if the spelled out version is easier to read, use that.

``` coffeescript
"width" > "w"
"height" > "h"
"x"
"y"
"JSON" > "JavaScriptObjectNotation"
"src" == "source"
"directory" > "dir"
"createDirectory" > "mkdir"
"background" > "bg"
```

## Remove trailing whitespace

[todo] create a command to strip trailing whitespace.

## Use 2 soft spaces `  `, not 1 tab `\t`

## Use coffeescript array assignments

Do this:

``` coffeescript
[one, two] = [1, 2]
```

Instead of this:

``` coffeescript
array = [1, 2]
one   = array[0]
two   = array[1]
```

## Use the `=>` operator instead of `_this`, `_self`, etc.

When using the double arrow operator `=>`, coffeescript generates `var _this = this` for the wrapping method, so wherever you use `this.aMethod()` or `@aMethod()` it will replace it with `_this.aMethod()`, so you don't have to mess around with setting up the right binding context manually.

``` coffeescript
methods =
  a: ->
    self = @

    defineSelfExplicitly = -> # single arrow
      self.c()

    defineSelfExplicitly()

  b: ->
    defineSelfImplicitly = => # double arrow
      @c()

    defineSelfImplicitly()

  c: ->
    console.log 'called c'
```

## Group public/private methods

Put private methods at the bottom of the file, even if they're named after a public method.  Reason: it's easier to read the code, you get the API first, then the implementation.

Correct:

``` coffeescript
set: ->

get: ->

_set: ->

_get: ->
```

Incorrect:

``` coffeescript
set: ->

_set: ->

get: ->

_get: ->
```

## Align `=` and `:`

- align semicolons on the left
- align equal signs on the right, 2n tabs in (falls on an even number of whitespaces)

### Minimize the number of methods

- less code to manage
- fewer methods to memorize
- smaller footprint (less code for the browser to download)
- differs from Rails
- opt-in helper method generation

```
model.buildRelation("user") # can opt into
# vs.
model.buildUser()
```

Convert `model.store()` to a `store()` method on the class ONLY IF the number of times you use the method is such that creating the "wrapper" method would save on the number of characters in the js/coffee file (so when it's minimized, it's maximally minimized).  That is, if you only call the long method once, don't wrap it, just deal with it.  Or, if the method is sufficiently complex and needs to be tested, and is still only used once, then make it a method and test it. Better to test than to not.

### Use single underscore for Ruby-ish `bang!` methods: `create_()`.

### Organize the code so it can be compiled for the client

- put `module.exports = X` at the bottom of each file so it can be stripped with a regular expression.

### Create Underscore.js Compatible Helpers

- write helpers so they are independent of underscore but can be swapped.

## Tips

#### Create a namespace for your app.

This makes it so you don't have to use `require` everywhere on the client, setting the same variable over and over again.

``` coffeescript
class MyApp.User
  @include Tower.Model
```

or

``` coffeescript
class User
  @include Tower.Model

MyApp.User = User
```

Instead of

``` coffeescript
# user.coffee
class User
  @include Tower.Model

module.exports = User

# somewhere else
User = require('../app/models/user')
```

Because of the naming/folder conventions, you can get away with this without any worries.  It also decreases the final output code :)

## CoffeeScript Cheat Sheet

### `=>` vs `->`

### `key in object`

``` coffeescript
return true if key of object
return true if object.hasOwnProperty(key)
```

### `{key1, key2}`

### `{@key1}`

``` coffeescript
@render "action", locals: {post: @post}
@render "action", locals: {@post}
```

## OR=

``` coffeescript
a ?= true

b ||= true

c or= true
```

``` javascript
if (typeof a === "undefined" || a === null) a = true;

b || (b = true);

c || (c = true);
```

## Comment your code (when the time is right)

Here is the structure of a comment (using `codo`):

``` coffeescript
# Title goes here, single line if possible,
# otherwise overflow to next line with no blank line
# in between.
# 
# Can put some more description here, 
# multiple lines if desired.
# You can also use **markdown** anywhere in the comment!
# 
# @todo Mark it with todo just after the title and [optional] description,
#   and indent if multiple lines (indent anything following `@[keyword]`).
# 
# @example Optional example with optional title
#   # This will be syntax highlighted
#   add(1, 2) #=> 3
# 
# @param [Integer] a First integer
# @param [Integer] b Second integer
# 
# @return [Integer] Put the return value last
add = (a, b) ->
  a + b
```

## Write consistent comments

- Keep blank line above new comments
- except at the start of a file
- or a new level of indentation

Good:

``` coffeescript
# This class maps a user to a group
class App.Membership extends Tower.Model
  # I am a new level of indentation...
  @field 'role'

  # ...and I'm not
  @belongsTo 'user'
  @belongsTo 'group'
```

Bad:

``` coffeescript

# This class maps a user to a group
class App.Membership extends Tower.Model

  # I am a new level of indentation...
  @field 'role'
  # ...and I'm not
  @belongsTo 'user'
  @belongsTo 'group'
```

You also should avoid using `###` block comments, because while they may prevent having to start every line with a `#`, it breaks up your code in ways that make it hard to read. Only use block comments to comment out large portions of your code, not for writing documentation within.

## Tower.Model style conventions

Order executable class methods in this order: concerns (mixins, unless mixin depends on things defined later in class), `field`, field helpers (i.e. `timestamps`), associations (`belongsTo` first since it adds a field for the association id, then `hasOne`, and `hasMany`), association helpers (i.e. `acceptsNestedAttributesFor`, or custom plugins), mass assignment protection (i.e. `@protected` and `@accessible`), scopes, validations, class methods, instance methods. Separate each different section with a blank line, and keep related items with no blank line between. This is all optional, but is helpful for reading and understanding someone else's code. The most important thing is to use consistent spacing.

``` coffeescript
class App.User extends Tower.Model
  if Tower.isServer
    @include App.UserAuthenticationConcern

  @field 'firstName'
  @field 'lastName'
  @field 'role'

  @timestamps()

  @belongsTo 'address'

  @hasOne 'profile'

  @hasMany 'memberships'
  @hasMany 'groups', through: 'memberships'

  @acceptsNestedAttributeFor 'memberships'

  @protected 'role'

  @scope 'admin', role: 'admin'

  @validates 'firstName', 'lastName', presence: true

  @welcome: (id, callback) ->
    @find id, (error, user) =>
      if user
        App.Notification.welcome(user).deliver(callback)
      else
        callback.call(@, error)

  welcome: (callback) ->
    @enqueue 'welcome', @get('id'), callback
```