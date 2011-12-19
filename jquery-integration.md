# jQuery Integration

## DOM Events

Initialization events can be added to the application like this:

``` coffeescript
$(document).ready -> MyApp.fire "ready"
$(window).load    -> MyApp.fire "load"
$(window).unload  -> MyApp.fire "unload"
```

You can then use them like this:

``` coffeescript
MyApp.on "ready", ->
  alert "ready!"
```

...or abstracted away in helpers:

``` coffeescript
MyApp.Helpers.FormHelper =
  extended: ->
    @on "ready", ->
      @initializeValidations()
      @initializeKeyboard()
      
    @on "unload", ->
      # save unsaved data
      
MyApp.include MyApp.Helpers.FormHelper
```
