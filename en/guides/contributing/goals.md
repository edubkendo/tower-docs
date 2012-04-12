## Minimal amount of code

Every method should strive to be as simple as possible while still being able to handle as many cases as possible.  Refactor it into something reusable if possible.  Sacrifice performance only when you eliminate a lot of code (by "performance", I'm talking about differences like those between functions and for loops for iterating).

## The most efficient implementations

Every method should not only be minimal, it should also be efficient, using formal algorithms where possible.  But, if the algorithm implementation is significantly longer than a less efficient solution, or you'd have to import an external dependency, go with the less efficient solution, somehow get that external library to be part of something standard like underscore.js, or create a new algorithm.

## Minimize the amount of methods you have on the class

There is a tradeoff here.  If you're going to be using some set of functionality on a class all the time, then go with whatever's simpler for the developer.  However, if it's an edge/uncommon case, then wrap it in a nested object.

An example is with the finder API vs configuration variables.

Instead of doing this for configuration, which just adds a bunch of methods to the API:

``` coffeescript
class App.User extends Tower.Model
  @defaultScope @desc("createdAt")
  @collectionName "people"
```

Do this:

``` coffeescript
class App.User extends Tower.Model
  @configure
    scope:          @desc("createdAt")
    collectionName: "people"
```

This way we have 1 method, `configure`, instead of potentially dozens of methods.  This makes the class feel much lighter and easier to work with.

But when you use the methods all the time, you don't want to have to drill down through an object (law of demeter).  You can see this through the scoping api

Imagine writing this a 100 times:

``` coffeescript
User.criteria().where(firstName: "Lance")
```

instead of this:

``` coffeescript
User.where(firstName: "Lance")
```

In the first case, we have a simpler api, but it makes development more burdensome and less intuitive.  In the second case, it's very clear what's going on, even though we add several methods (`where`, `anyIn`, etc.) to the class API.

A tricky case is with methods for model naming: `toKey`, `toParam`, etc.  Those are not that commonly used, but it makes sense doing `model.toParam()` rather than something like `model.names().param`.  This is where you have to make the call.  I tend to go with putting it all in a nested object, and then adding methods if it turns out it would make life easier down the road.  Don't prematurely add methods unless it's just totally obvious you'll be using them.

## Build it so you can Progressively Add Features

Instead of making it so the `model.set` method can do _everything_, make it handle the simple case and make that module usable by itself.  This way, if you have a simple app, you can use the version/parts of the library that's a lot lighter than the complete solution.  But also make it so it doesn't require _too much_ memory/processing to append these new features if you do want them (other than the fact you'll have to load more code).  I'm talking about not forcing every module to call `super` if it overrides a method in a simpler method.  Somehow organize your code so you can minimize these types of extra method calls while still making it enhanceable.

## Minimize the number of singular/plural method implementations (purely aesthetic)

You can use both if it makes testing your methods easier, but just make sure it's not purely aesthetic.

``` coffeescript
class App.User extends Tower.Model
  @default "store", Tower.Store.Memory
  @default "scope", @desc("createdAt")
```

``` coffeescript
class App.User extends Tower.Model
  @defaults store: Tower.Store.Memory, scope: @desc("createdAt")
```
