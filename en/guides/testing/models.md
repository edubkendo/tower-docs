# Testing Models in Tower.js

## Example

``` coffeescript
# ./test/models/userTest.coffee
describe "App.User", ->
  user = null
  
  describe "#fields", ->
    beforeEach (done) ->
      App.User.destroy =>
        user = new App.User
        
    test ".email", ->
      assert.ok user.has("email")
```
