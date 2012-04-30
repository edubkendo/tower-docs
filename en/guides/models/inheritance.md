# Inheritance

Tower supports inheritance in both root and embedded records. In scenarios where records are inherited from their fields, relations, validations and scopes get copied down into their child records, but not vise-versa.

``` coffeescript
class App.Canvas extends Tower.Model
  @field 'name', type: 'String'
  
  @hasMany 'shapes', embedded: true

class App.Browser extends App.Canvas
  @field 'version', type: 'Integer'
  
  @scope 'recent', @where(version: '>': 3)

class App.Firefox extends Browser

class App.Shape extends Tower.Model
  @field 'x', type: 'Integer'
  @field 'y', type: 'Integer'
  
  @belongsTo 'canvas', embedded: true

class App.Circle extends App.Shape
  @field 'radius', type: 'Float'

class App.Rectangle extends App.Shape
  @field 'width', type: 'Float'
  @field 'height', type: 'Float'
```

In the above example, Canvas, Browser and Firefox will all save in the canvases collection. An additional attribute `_type` is stored in order to make sure when loaded from the database the correct record is returned. This also holds true for the embedded records Circle, Rectangle, and Shape.

## Querying for Subclasses

Querying for subclasses is handled in the normal manner, and although the records are all in the same collection, queries will only return records of the correct type, similar to Single Table Inheritance in ActiveRecord.

``` coffeescript
# Returns Canvas records and subclasses
App.Canvas.where(name: 'Paper')
# Returns only Firefox records
App.Firefox.where(name: 'Window 1')
```

## Associations

You can add any type of subclass App.to a has one or has many association, through either normal setting or through the build and create methods on the association:

``` coffeescript
firefox = new App.Firefox
# Builds a Shape object
firefox.shapes.build({ x: 0, y: 0 })
# Builds a Circle object
firefox.shapes.build({ x: 0, y: 0 }, Circle)
# Creates a Rectangle object
firefox.shapes.create({ x: 0, y: 0 }, Rectangle)

rect = App.Rectangle.new(width: 100, height: 200)
firefox.shapes
```
