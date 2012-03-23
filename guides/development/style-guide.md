# Design Principles

## Avoid CoffeeScript Keywords

- Don't use any "JS_KEYWORDS" words that CoffeeScript allows you to use, because even though you can do `user.delete()` in CoffeeScript, you'd have to write `user["delete"]()` in JavaScript.  These words are:

`true`, `false`, `null`, `this`, `new`, `delete`, `typeof`, `in`, `instanceof`, `return`, `throw`, `break`, `continue`, `debugger`, `if`, `else`, `switch`, `for`, `while`, `do`, `try`, `catch`, `finally`, `class`, `extends`, `super`

## Use the `=>` operator instead of `_this`, `_self`, etc.

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

### Use single underscore for Ruby-ish `bang!` methods: `_create()`.

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

