# Performance Optimizations

## Resources

- http://developer.yahoo.com/performance/rules.html

## Tips

- develop against a set of fixtures so you're dealing with the same graphics every time you refresh the page (uploaded images, etc.).  but also be able to create new things
- be able to reset the db back to the base "fixtured" state.
- use `console.log` and related on the client so you can see the line number (i.e. don't wrap it)
- http://jsperf.com/dynamic-arguments

## Classes

``` ruby
class User
  has_many :posts
end
```

``` coffeescript
class User
  @has_many "posts"
```

## Modules

``` ruby
module Associations
  included do
    
  end
  
  module ClassMethods
    def has_many(*args)
      
    end
    
    def reflections
      
    end
  end
  
  module InstanceMethods
    def reflections
      self.class.reflections
    end
  end
end
```

``` coffeescript
Associations = 
  included: ->

  ClassMethods:
    has_many: ->
    
    reflections: ->

  InstanceMethods:
    reflections: ->
      @constructor.reflections()
```

## `instance_eval`

``` ruby
user.instance_eval do
  puts self.class.name
end
```

``` coffeescript
Object.prototype.instance_eval = (block) ->
  block.call(@)
  
user.instance_eval ->
  console.log @constructor.name
```

## Extract Args and Options

``` ruby
# args is a plain array
def find(*args)
  options = args.extract_options!
end
```

``` coffeescript
# args is an "Arguments" object
find: ->
  args    = extract_args(arguments)
  options = extract_options(args)
```

## Async Loops

``` coffeescript
repeater = (i) ->
  if i < length
    asyncwork ->
      repeater i + 1
repeater 0
```

## [Function Call vs. Class Performance](http://jsperf.com/function-vs-new-object-call)

``` coffeescript
# http://jsperf.com/function-vs-new-object-call
class TestClass
  constructor: ->
    1 + 1

testFunction = ->
  1 + 1
  
new TestClass() # 7,486,425 ops/sec
testFunction()  # 108,392,512 ops/sec
```

## [Method vs. Getter Performance](http://jsperf.com/function-call-vs-getter)

``` coffeescript
# http://jsperf.com/function-call-vs-getter
class TestClass
  method: ->
    1 + 1
    
  getOrSet: ->
    if arguments.length > 0 then 1 + 1 else @["_getOrSet"] = arguments

Object.defineProperty TestClass.prototype, "getter", 
  get: -> 1 + 1

object = new TestClass

object.method()             # 28,804,533 ops/sec
object.getter               # 15,671,784 ops/sec (50% slower)
object.method.call(object)  # 27,044,957 ops/sec
object.method.apply(object) # 28,804,533 ops/sec
object.getOrSet()           # 2,920,880  ops/sec (90% slower)
```

## Method Missing in JavaScript

Replace all function calls to `object.send(name, arguments...)` with node burrito, like this guy does: http://www.ruby-forum.com/topic/128539.