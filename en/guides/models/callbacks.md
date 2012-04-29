# `Tower.Model.Callbacks`

Tower supports 3 main callbacks:

- `before`
- `around`
- `after`

The following callbacks are implemented:

- `@after   'initialize'`
- `@before  'validate'`
- `@after   'validate'`
- `@before  'create'`
- `@after   'create'`
- `@before  'update'`
- `@after   'update'`
- `@before  'save'`
- `@after   'save'`
- `@before  'destroy'`
- `@after   'destroy'`

Callbacks are available on any model.

## Define a callback with the callback phase helpers

``` coffeescript
class App.Post extends Tower.Model
  @field 'title', type: 'String'
  @field 'slug', type: 'String'
  
  @before 'save', 'generateSlug'
  
  generateSlug:  ->
    @set 'slug', @get('title').replace(/[^a-z0-9]+/, '-').toLowerCase()
```

## Define the phase and callback directly

``` coffeescript
class App.Post extends Tower.Model
  @field 'title', type: 'String'
  @field 'slug', type: 'String'
  
  @callback 'save', 'before', 'generateSlug'
  
  generateSlug:  ->
    @set 'slug', @get('title').replace(/[^a-z0-9]+/, '-').toLowerCase()
```

## Define callbacks with anonymous functions

``` coffeescript
class App.Post extends Tower.Model
  @field 'title', type: 'String'
  @field 'slug', type: 'String'
  
  @before 'save', ->
    @set 'slug', @get('title').replace(/[^a-z0-9]+/, '-').toLowerCase()
```

## Callbacks can be asynchronous

If you have a callback that executes asynchronous code, you can add the `callback` argument to your function, and call it when complete:

``` coffeescript
class App.Post extends Tower.Model
  @field 'title', type: 'String'
  @field 'url', type: 'String'
  
  @before 'save', 'scrapeWebsite'
  
  scrapeWebsite: (callback) ->
    SomeCrawler.scrapeHTML @get('url'), (error, html) ->
      callback(error)
```

Callbacks are called _in series_, so if you have several async callbacks, know they will be executed one after another.