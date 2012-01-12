# jQuery Integration

## DOM Events

Initialization events can be added to the application like this:

``` coffeescript
$(document).ready -> App.fire "ready"
$(window).load    -> App.fire "load"
$(window).unload  -> App.fire "unload"
```

You can then use them like this:

``` coffeescript
App.on "ready", ->
  alert "ready!"
```

...or abstracted away in helpers:

``` coffeescript
App.Helpers.FormHelper =
  extended: ->
    @on "ready", ->
      @initializeValidations()
      @initializeKeyboard()
      
    @on "unload", ->
      # save unsaved data
      
App.include App.Helpers.FormHelper
```
