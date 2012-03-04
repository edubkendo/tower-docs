# Features

Version with `v0.8.7-1`

- `Store` layer to all popular databases, which just normalizes the data for the `Model` layer.
  - MongoDB
  - Redis
  - [Cassandra](https://github.com/wadey/node-thrift)
  - PostgreSQL
  - CouchDB
- `Model` layer with validations, sophisticated attribute management, associations, named and chainable scopes, etc.
- `Controller` layer that works pretty much exactly like the Rails controller system.
- `View` layer which works just like Rails
- `Route` layer, which handles mapping and finding routes
- `Event` layer, for callbacks and event management [todo]
- `Asset` layer, for asset compression pipeline just like Sprockets + Rails.  Handles image sprite creation too.
- `I18n` layer [todo]
- `Spec` layer for setting up tests for your app just like Rails.
- `Generator` [todo]
- `Component` layer, for building complex forms, tables, widgets, etc. [todo]
- `Template` layer, so you can swap out any template engines. In the [Node.js Shift Module](https://github.com/viatropos/shift.js).
- Can also use on the client:
  - Model
  - View
  - Controller
  - Route
  - Template
  - Support
- Optimized for the browser.



# Tower.js

Tower is a lightweight framework for building JavaScript web applications.  Tower follows the same principles as Rails, giving you a clear MVC convention that makes building large-scale JavaScript apps fun and real easy.  It was built to allow you to write one set of JavaScript code that works on both the client and server.  It's crazy how much faster you can move with just that one small change.

Tower was written with CoffeeScript in mind.  It uses Rails-esque conventions, and a Ruby-like syntax, so your app is built with classes.  You don't have to use these conventions, and you can are free to write your app in purely JavaScript.  But the CoffeeScript version makes it super easy to do a lot.

- Built for and by hackers
  - Like you, we love building awesome things.
- Built for node.js and the browser
  - built on top of express and connect
- Convention over configuration
- Built on CoffeeScript
- simplicity in form and function
- template engine agnostic
- eliminate boilerplate
- no built-in bindings (pick your own, or don't use at all!)
- predictable expectation over time
- humans love patterns & structure
- simplifies building single page apps
- composable (so mobile version is super tiny with only basic functionality for example)
- use convention instead of events (you'll see why, way more powerful).  "MVC" proper vs. MVC practical
- RESTful JSON interface
- needed a better way to manage events and callbacks
- super easy testing
- provides architecture

- HTML5
- CSS3
- MongoDB
- jQuery
- Open Source
- Node.js
- CoffeeScript

- http://emberjs.com/
- http://mongoid.org/docs.html

## Tower Namespace API

- urlFor
- get
- post
- put
- destroy
- index
- show
- hide
- next
- prev