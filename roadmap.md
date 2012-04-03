# Roadmap

Tower is currently at version 0.3.9-x.  Going to move to 0.4.0 once it looks like everyone is able to build an app - just about there.

For 0.5.0, Tower will include the features below.  It's going to be a rolling list.  If you have ideas or features you'd like to see, include them in the section [Potential features](#potential-features) section and we'll move them up if they're in scope.

Let me know if you'd like to implement any of these things, will help speed up the process.

You are free to implement any of these features in any order… I'm more of a fan of doing what you want when you want to, as long as it follows some general plan.  I stay motivated and get way more done that way.

<a name="features-0.5.0" href="features-0.5.0"></a>

## 0.5.0 - Full Featured Release

### 0.4.0 (functional release)

- ~~urlFor helpers~~
- ~~Extend helper method urlFor so that can it resolve to registered paths (aliases) for routes~~
  - ~~`urlFor route: 'signIn'`~~
- finish resourceful routes
- auto-restart server when file changes (development)
- ~~hasMany through associations (`Post.hasMany "comments"; Post.hasMany "commenters", through: "comments"`)~~
- mongo embedded documents
- ~~database seeds~~
- ~~test model pagination~~

### 0.4.1 (tests)

- generate `test/models` with example code for scaffold
- generate `test/routes` or `test/controllers` with example code for scaffold
- test inheritance with type property
- extends hook for coffeescript
- test factories (something like factory.js)
- mock/test setup for http requests (controllers)
- generators for tests
- test the generator code

### 0.4.2 (controllers)

- better controller rendering
- some sort of `updateAll`|`deleteAll` ​functionality for controllers (array of ids)
- finalize resourceful controller actions (see https://github.com/​josevalim/inheritedResources)
- error hooks for controllers
- test subdomains on heroku
- switch to parsing url params with URI.js
- basic controller logging
- https helper methods
- http caching methods in the controller
- redirect helpers at the top level, so you easily write permanent redirects (http://stackoverflow.com/​questions/4046960/how-to-​redirect-without-www-using-​rails-3-rack)

### 0.4.3 (models)

- basic model logging
- uniqueness validation (database should not save a record unless specified attributes are globally unique (i.e. username))
- email/phone validation (and other common validation helpers)
- i18n (internationalization/​localization, how to organize the random labels in the app, and prepare for translation into other languages)

### 0.4.4 (model attachments)

- test storing images/blobs in mongo (GridFS?)
  - "Binary" data type?
  - http://blog.james-carr.org/2012/01/09/streaming-files-from-mongodb-gridfs/
- test storing images on s3
- get progress bar feedback for streaming file uploads
  - http://debuggable.com/posts/streaming-file-uploads-with-node-js:4ac094b2-b6c8-4a7f-bd07-28accbdd56cb
- image/asset/attachment model api (see https://github.com/​thoughtbot/paperclip)

### 0.4.5 (views)

- test client side view rendering with coffeekup
- automatic form validations based on model of client
- error/stacktrace printing when view fails to fully render
- finish table builder

### 0.4.6 (sockets)

- push notifications (web socket integration into the controllers)
- test client-side sockets
- swappable sockets api (socket.ly, socket.io)

### 0.4.7 (background jobs, emails)

- background queuing with redis (`User.queue("welcome", 1)` vs. `User.welcome(1)`, for background processing) - https://github.com/technoweenie/coffee-resque
- Test the mailer (already implemented but needs tests)
- inline css in email templates

### 0.4.8 (models [robustness])

- add includes to associations: `Post.includes("​author").where(author: firstName: "=~": "Baldwin").all()`
- model indexes in mongodb (and potentially in memory, i.e. a redis-like plugin for the browser)
- database "cleaner" code for tests

### 0.4.9 (cleanup, optimizations, configuration, documentation)

- chunk code into parts for the client, so you can use only bare minimum if desired
- finalize tower.js internal code organization
- customize template engine, orm, and test framework in App.config
- underscore integration (cleanup/finalize, you easily spend a lot of your time formatting dates, numbers, and strings once the base app is in place)
  - date helpers, string helpers, number helpers
- design.io updates:
  - growl notifications
  - auto-run tests
- document code
- make sure class methods and subclasses work correctly*

### 0.5.0 (theme)

- basic responsive admin theme, with functionality like http://activeadmin.info/
- client and server have the same interface, separate code out so client is as lean as possible
- make sure templates have proper escaping (xss protection)

### 0.5.1 (benchmarking)

- cache manifest: https://github.com/​johntopley/manifesto
- integrate "use strict"; into the codebase
- benchmarks folder with stress tests

## Separate plugins

### TowerPassport

- authentication extension (so it's easy to start using authentication, potentially with passport
- tower generate authentication Session
- see [devise](https://github.com/plataformatec/devise) for inspiration, but I'm not a fan of devise b/c it's way too hard to customize and creates too much abstraction.  But the feature set it includes is great.  https://github.com/plataformatec/devise/wiki/OmniAuth:-Overview

### Tower.Authorization (TowerCanDo)

- authorization extension (https://github.com/ryanb/​cancan)

### Tower.Attachment

- paperclip?

### NestedSet

- https://github.com/collectiveidea/awesome_nested_set for hierarchical relationships

### StateMachine

- https://github.com/pluginaweek/state_machine

### Factory

- https://github.com/thoughtbot/factory_girl

### Existing / External Plugins to Integrate

Ideally we'd be able to make these libraries much smaller so we could use _all_ of them on the iPhone, but for now they handle tons of use cases and with gzipping it should be reasonably small.

- validation: https://github.com/chriso/node-validator
- url parsing: https://github.com/medialize/URI.js
- history pushState: https://github.com/balupton/History.js/
- date parsing: https://github.com/timrwood/moment

I'm all about fully featured and tested + small file size, but given a robust library already exists, I'm going with that until I find a way to rewrite it better.

## Support for alternative data stores (as plugins) 

These are next, larger features.  These will be included in earlier releases if a member of the community contributes them.  Otherwise they might be approached after the 0.5.0 release according to community requests.

- Neo4j support
- CouchDB support
- (PostGreSQL support ?)
- (MySQL support ?)

<a name="potential-features" href="potential-features"></a>

## Potential Features

- hierarchical models (nested sets)
- state machine (see [https://github.com/pluginaweek/stateMachine](https://github.com/pluginaweek/stateMachine))
