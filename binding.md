<div>You've clicked <span data-bind="text: numberOfClicks">&nbsp;</span> times</div>
 
<button data-bind="click: registerClick, enable: !hasClickedTooManyTimes()">Click me</button>
 
<div id='too-many' data-bind="visible: hasClickedTooManyTimes">
    That's too many clicks! Please stop before you wear out your fingers.
    <button data-bind="click: function() { numberOfClicks(0) }">Reset clicks</button>
</div>

Metro.bind "visible", id: "#too-many"

$("#user-first-name-input").change ->
  value = $(this).value()
  if value && value != ""
    $("#user-last-name-input").attr("disabled", false)
  else
    $("#user-last-name-input").attr("disabled", true)

bind "#user-last-name-input", "disabled", "#user-first-name-input", value: presence: true

# BETTER
@dispatcher = global || window

$(@dispatcher).on "change", (event) ->
  

$("#user-first-name-input").change ->
  value = $(this).value()
  model = User.current()
  model.set("firstName", value)

bind "#user-last-name-input", "disabled", "!!User.current().firstName"

## METHOD 1

@bind "#user-first-name-input", set: (value) -> @resource.firstName = value, event: "keypress"
@bind "#user-first-name-input", "firstName"

## Method 2

@on "change #user-first-name-input", "firstNameChanged"

changedFirstName = (value) ->
  if _.blank(value)
    @elements.userLastNameInput.attr("disabled", true)
  else
    @elements.userLastNameInput.attr("disabled", false)
    
## Method 2b

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
  
addAddress: ->
  address = @user.addresses.build()
  $("#user-addresses").append $("#user-address-template").tmpl(address)
  
removeAddress: (id) ->
  $("#user-addresses ##{id}").remove()
  
toggleDetails: ->
  $(@selector).toggle()

## Method 3

bind  = (selector, options) ->
  bindings[selector] ||= []
  bindings[selector].push options
  
$(@dispatcher).on "keypress", (event) ->
  target  = $(event.target)
  id      = target.attr("id")
  each    = bindings[id]
  return event unless each
  for binding in each
    if binding.hasOwnProperty("value")
      binding.value(target.val())
  event
  
## Method 4

presenter.firstName.on "change", (value) ->
  if _.blank(value)
    $("#user-last-name-input").attr("disabled", true)
  else
    $("#user-last-name-input").attr("disabled", false)
    
presenter.firstName.on "change", (value) ->
  if _.blank(value)
    $("#user-last-name-input").attr("disabled", true)
  else
    $("#user-last-name-input").attr("disabled", false)
  
bind "#user-last-name-input", enable: "presenter.firstNameOrEmailPresent()", triggers: [presenter.firstName, presenter.email]

bind  = (selector, type, observable) ->
  observable.on "update", (value) ->
    elements[selector] ||= $(selector)
    bindingDefinitions[type](elements[selector], value)

bind "disabled:presence", @user, selector: "#user-last-name-input", attribute: "firstName"

bindingDefinitions =
  "disabled:presence": (element, value) ->
    if value && value != ""
      $(element).attr("disabled", false)
    else
      $(element).attr("disabled", true)
      
bind = (type, context, options = {}) ->
  context.on "#{options.attribute}Change", (value) ->
    bindingDefinitions[type] $(options.selector), value