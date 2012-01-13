# Callbacks

Tower supports 3 main callbacks:

- `before`
- `around`
- `after`

The following callbacks are implemented:

- `@after   "initialize"`
- `@before  "validate"`
- `@after   "validate"`
- `@before  "create"`
- `@around  "create"`
- `@after   "create"`
- `@before  "update"`
- `@around  "update"`
- `@after   "update"`
- `@before  "save"`
- `@around  "save"`
- `@after   "save"`
- `@before  "destroy"`
- `@around  "destroy"`
- `@after   "destroy"`

Callbacks are available on any model, whether it is embedded within another model or not.

## Define a callback with the callback phase helpers

``` coffeescript
class Post extends Tower.Model
  @field "name", type: "String"
  @field "slug", type: "String"
  
  @before "save", "generateSlug"
  
  generateSlug:  ->
    @set "slug", @get("name").replace(/[^a-z0-9]+/, '-').toLowerCase()
```

## Define the phase and callback directly

``` coffeescript
class Post extends Tower.Model
  @field "name", type: "String"
  @field "slug", type: "String"
  
  @callback "save", "before", "generateSlug"
  
  generateSlug:  ->
    @set "slug", @get("name").replace(/[^a-z0-9]+/, '-').toLowerCase()
```

## Define callbacks with anonymous functions

``` coffeescript
class Post extends Tower.Model
  @field "name", type: "String"
  @field "slug", type: "String"
  
  @before "save", ->
    @set "slug", @get("name").replace(/[^a-z0-9]+/, '-').toLowerCase()
```
