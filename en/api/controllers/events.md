# Events

All controller actions are just events.  This means then that controllers handle events:

- DOM events
- Keyboard events
- Gesture events
- socket messages
- url requests

Instead of having to create a controller for each type of message, why not just establish some conventions:

``` coffeescript
class App.PostsController extends Tower.Controller
  # socket.io handler
  @on "create", "syncCreate" # created by default... knows because it's named after an action
  @on "notification", "flashMessage" # knows it's socket because 'notification' isn't an action or dom event keyword
  @on "mousemove", "updateHeatMap", type: 'socket' # if you name a socket event after a keyword then pass the `type: 'socket'` option.
  
  # dom event handler
  @on "click", "click"
  @on "click .item a", "clickItem"
  # or as an object
  @on "click .itemA a": "clickItemA",
    "click .itemB a": "clickItemB",
    "click .itemC a": "clickItemC"
  
  @on "change #user-first-name-input", "enable", dependent: "#user-last-name-input"
  @on "change #user-first-name-input", "enable #user-last-name-input" # enable: (selector)
  @on "change #user-first-name-input", "validate"
  @on "change #user-first-name-input", bind: "firstName"
  @bind "change #user-first-name-input", "firstName"
  @on "click #add-user-address", "addAddress"
  @on "click #add-user-address", "add", object: "address"
  @on "click #remove-user-address", "removeAddress"
  # $(window).on('click', '#user-details', "toggleDetails");
  @on "click #user-details", "toggleDetails"

  # show or hide
  toggleShowHide: ->

  show: ->

  hide: ->

  toggleSelectDeselect: ->

  select: ->

  deselect: ->

  toggleAddRemove: ->

  add: ->

  remove: ->

  toggleEnableDisable: ->  
    if _.blank(value)
      @disable()
    else
      @enable()

  # enable or disable
  enable: ->
    $(options.dependent).attr("disabled", false)

  disable: ->
    $(options.dependent).attr("disabled", true)

  validate: (element) ->
    element

  invalidate: ->

  bind: ->
  
  next: ->
    
  prev: ->
```