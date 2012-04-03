specialProperties = ['included', 'extended', 'prototype', 'ClassMethods', 'InstanceMethods']

Tower.Support.Object =
  extend: (object) ->
    args = Tower.Support.Array.args(arguments, 1)

    for node in args
      for key, value of node when key not in specialProperties
        object[key] = value

    object

  accessor: (object, key, callback) ->
    object._accessors ||= []
    object._accessors.push(key)
    @getter(key, object, callback)
    @setter(key, object)

    @

  setter: (object, key) ->
    unless object.hasOwnProperty("_setAttribute")
      @defineProperty object, "_setAttribute",
        enumerable: false,
        configurable: true,
        value: (key, value) ->
          @["_#{key}"] = value

    object._setters ||= []
    object._setters.push(key)

    @defineProperty object, key,
      enumerable: true,
      configurable: true,
      set: (value) ->
        @["_setAttribute"](key, value)

    @

  getter: (object, key, callback) ->
    unless object.hasOwnProperty("_getAttribute")
      @defineProperty object, "_getAttribute",
        enumerable: false,
        configurable: true,
        value: (key) ->
          @["_#{key}"]

    object._getters ||= []
    object._getters.push(key)

    @defineProperty object, key,
      enumerable: true,
      configurable: true,
      get: ->
        @["_getAttribute"](key) || (@["_#{key}"] = callback.apply(@) if callback)

    @

  variables: (object) ->

  accessors: (object) ->

  methods: (object) ->
    result = []
    for key, value of object
      result.push(key) if @isFunction(value)
    result

  delegate: (object, keys..., options = {}) ->
    to          = options.to
    isFunction  = @isFunction(object)

    for key in keys
      if isFunction
        object[key] = ->
          @[to]()[key](arguments...)
      else
        @defineProperty object, key,
          enumerable: true,
          configurable: true,
          get: -> @[to]()[key]

    object
