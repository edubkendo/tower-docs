# Design Principles

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

### Use double underscore `__name` for private/protected methods

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
