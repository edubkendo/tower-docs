###
$ ->
  $.fn.serializeParams = (coerce) ->
    $.serializeParams($(this).serialize(), coerce)

  $.serializeParams = (params, coerce) ->
    obj = {}
    coerce_types =
      true: not 0
      false: not 1
      null: null
    
    array = params.replace(/\+/g, " ").split("&")
    
    for item, index in array
      param = item.split("=")
      key = decodeURIComponent(param[0])
      val = undefined
      cur = obj
      i = 0
      keys = key.split("][")
      keys_last = keys.length - 1
      if /\[/.test(keys[0]) and /\]$/.test(keys[keys_last])
        keys[keys_last] = keys[keys_last].replace(/\]$/, "")
        keys = keys.shift().split("[").concat(keys)
        keys_last = keys.length - 1
      else
        keys_last = 0
      if param.length is 2
        val = decodeURIComponent(param[1])
        val = (if val and not isNaN(val) then +val else (if val is "undefined" then `undefined` else (if coerce_types[val] isnt `undefined` then coerce_types[val] else val)))  if coerce
        if keys_last
          while i <= keys_last
            key = (if keys[i] is "" then cur.length else keys[i])
            cur = cur[key] = (if i < keys_last then cur[key] or (if keys[i + 1] and isNaN(keys[i + 1]) then {} else []) else val)
            i++
        else
          if $.isArray(obj[key])
            obj[key].push val
          else if obj[key] isnt `undefined`
            obj[key] = [ obj[key], val ]
          else
            obj[key] = val
      else obj[key] = (if coerce then `undefined` else "")  if key

    obj
    
  model = "category"
  field = (attribute, options = {}) ->
    parts     = [model, attribute]
    inputId   = parts.join("-")
    inputName = parts.shift()
    inputName += "[#{part}]" for part in parts
    optional  = "optional" # || "required"
    optionalAbbr = ""
    
    """
      <li class='field #{options.type}' id='#{inputId}-field'>
        <label for='#{inputId}'>
          <span>#{options.label}</span>
          <abbr class='#{optional}'>#{optionalAbbr}</abbr>
        </label>
        <input name='#{inputName}' id='#{inputId}-input' type='#{options.type}' value='#{options.value}'/>
      </li>
    """

  unless $("#category-form-form").length
    form = """
      <form action='/admin/tiles/10/categories/new' method='post' id='category-form' class='new' data-method='post'>
        #{field('name', type: 'text', value: '', label: 'Category Name')}
        <input type='submit' class='submit'/>
      </form>
    """
    $("body").prepend(form)
    
  $("#category-form.new").click() == true

Metro.dispatcher = Metro.Controller.dispatcher = window

Metro.Model::save = (options, callback) ->
  if typeof options == "function"
    callback  = options
    options   = {}
  
  unless options.validate == false
    unless @validate()
      callback.call @, null, false if callback
      return false
  
  if @isNew()
    @_create(callback)
  else
    @_update(@toUpdates(), callback)
    
  true

Metro.Model::_update = (attributes, callback) ->
  @constructor.update @id, attributes, (error) =>
    @changes = {} unless error
    callback.call(@, error, !error) if callback
  
  @
  
Metro.Model::_create = (callback) ->
  @constructor.create @attributes, (error, docs) =>
    @changes = {} unless error
    callback.call(@, error, !error) if callback
  
  @

Metro.Controller.instance = ->
  @_instance

Metro.Controller.on = ->
  args = Array.prototype.slice.call(arguments, 0, arguments.length).concat()
  if typeof args[0] == "string"
    event   = args.shift()
    action  = args.shift()
    options = args.shift() || {}
    @addListener(event, action)
  else
    options = args.shift()
    for event, action in options
      @addListener(event, action)
      
formHandler = (eventType, selector, handler) ->
  self = @
  
  $(@dispatcher).on eventType, (event) ->
    controller = self.instance()
    
    form    = $(event.target).closest("form")
    action  = form.attr("action")
    method  = (form.attr("data-method") || form.attr("method")).toUpperCase()
    body    = form.serializeParams()
    
    controller.params ||= {}
    params  = _.extend controller.params, body
    
    controller[handler].call controller, arguments...

Metro.Controller.addListener = (name, handler) ->
  parts     = name.split(/\s+/)
  event     = parts.shift()
  selector  = parts.join(" ")
  
  formHandler.call @, event, selector, handler

Metro.Controller.removeListener = (name, handler) ->
  
  
Metro.Support.I18n.store().en =
  model:
    errors:
      presence: "Not present!"

Metro.Support.I18n.interpolator = -> render: (string) -> string

class Metro.Controller.Responder
  constructor: (formats = []) ->
    @accept(format) for format in formats
    
  accept: (format) ->
    @[format] = (callback) ->
      @[format] = callback

class RW.CategoriesController extends Metro.Controller
  @respondTo "html", "json"
  
  # "event #[model]-[attributes]-[element].[action]"
  @on "click #category-form.new", "create"
  @on "submit #category-form.edit .submit", "update"
  @on "keydown:down #category-list.edit .submit", "next", if: -> true
  @on "keydown:down #category-list.edit .submit", "prev", if: -> true
  @on "click #category-list .item", "toggle", if: -> true
  
  next: ->
    
  prev: ->
    
  toggle: ->
    $("##{@params.id}").toggleClass("selected")
    
  success: ->
    @level 1, =>
      @redirectTo @urlFor("admin", "categories")
    
  failure: (error) ->
    if error
      @flashError(error)
    else
      @invalidate()
    
  invalidate: ->
    element = $("##{@resourceName}-#{@elementName}")
    
    for attribute, errors of @category.errors
      field = $("##{@resourceName}-#{attribute}-field")
      if field.length
        field.css("background", "yellow")
        $("input", field).after("<output class='error'>#{errors.join("\n")}</output>")
        
  resourceName: Metro.Support.String.singularize(Metro.Support.String.camelize(@name.replace(/(Controller)$/, ""), true))
  resourceType: Metro.Support.String.singularize(@name.replace(/(Controller)$/, ""))
  resourceType: "MongoCategory"
  # based on action
  elementName: "form"
    
new RW.CategoriesController

###