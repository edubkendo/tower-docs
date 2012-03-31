# Testing Models

## Example

``` coffeescript
# ./test/models/userTest.coffee
require "../config"

user = null

describe "App.User", ->
  describe "#fields", ->
    beforeEach (done) ->
      App.User.destroy =>
        user = new App.User
        
    test ".email", ->
      assert.ok user.has("email")
```

