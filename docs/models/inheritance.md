# Inheritance

Tower supports inheritance in both root and embedded documents. In scenarios where documents are inherited from their fields, relations, validations and scopes get copied down into their child documents, but not vise-versa.

``` coffeescript
class Canvas extends Tower.Model
  field :name, type: String
  embeds_many :shapes

class Browser < Canvas
  field :version, type: Integer
  scope :recent, where(:version.gt => 3)

class Firefox < Browser
end

class Shape
  include Tower::Document
  field :x, type: Integer
  field :y, type: Integer
  embedded_in :canvas
end

class Circle < Shape
  field :radius, type: Float
end

class Rectangle < Shape
  field :width, type: Float
  field :height, type: Float
end
```

In the above example, Canvas, Browser and Firefox will all save in the canvases collection. An additional attribute _type is stored in order to make sure when loaded from the database the correct document is returned. This also holds true for the embedded documents Circle, Rectangle, and Shape.

## Querying for Subclasses

Querying for subclasses is handled in the normal manner, and although the documents are all in the same collection, queries will only return documents of the correct type, similar to Single Table Inheritance in ActiveRecord.

``` coffeescript
# Returns Canvas documents and subclasses
Canvas.where(name: "Paper")
# Returns only Firefox documents
Firefox.where(name: "Window 1")
```

## Associations

You can add any type of subclass to a has one or has many association, through either normal setting or through the build and create methods on the association:
firefox = Firefox.new
# Builds a Shape object
firefox.shapes.build({ x: 0, y: 0 })
# Builds a Circle object
firefox.shapes.build({ x: 0, y: 0 }, Circle)
# Creates a Rectangle object
firefox.shapes.create({ x: 0, y: 0 }, Rectangle)

rect = Rectangle.new(width: 100, height: 200)
firefox.shapes