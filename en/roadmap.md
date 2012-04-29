# Tower.js Roadmap

For 0.5.0, Tower will include the features below.  It's going to be a rolling list.  If you have ideas or features you'd like to see, include them in the section [Potential features](#potential-features) section and we'll move them up if they're in scope.

Let me know if you'd like to implement any of these things, will help speed up the process.

You are free to implement any of these features in any order… I'm more of a fan of doing what you want when you want to, as long as it follows some general plan.  I stay motivated and get way more done that way.

<a name="features-0.5.0" href="features-0.5.0"></a>

## 0.5.0 - Full Featured Release

<a name="0.4.0" href="0.4.0"></a>

### ✔ 0.4.0 (functional release)

- ~~Extend helper method urlFor so that can it resolve to registered paths (aliases) for routes~~
  - ~~`urlFor route: 'signIn'`~~
- ~~hasMany through associations (`Post.hasMany "comments"; Post.hasMany "commenters", through: "comments"`)~~
- ~~database seeds~~
- ~~test model pagination~~
- ~~auto-restart server when file changes (development)~~

<a name="0.4.1" href="0.4.1"></a>

### 0.4.1 (tests)

- ~~generate `test/models` with example code for scaffold~~
- ~~generators for tests~~
- ~~load tests in browser~~
- ~~make "database cleaner"~~
- ~~test setup for http requests (controllers)~~
- ~~test the command-line api~~
- ~~basic client test setup for tower development~~
- ~~extends hook for coffeescript~~
- ~~test "factories"~~
- ~~basic tests for socket.io~~
- generate `test/controllers` with example code for scaffold
- test the generator code
- NODE_ENV=production

<a name="0.4.2" href="0.4.2"></a>

### 0.4.2 (views)

- ember.js integration
- automatic form validations based on model of client
- error/stacktrace printing when view fails to fully render
- finish table builder
- make form builder more robust
- 404/etc error pages
- error handling on forms when validation error
- test client side view rendering with coffeekup
- test client side view rendering with ember
- test files reload when changed (integration test)
- test assets can be served with gzip

<a name="0.4.3" href="0.4.3"></a>

### 0.4.3 (controllers)

- finish resourceful routes
- better controller rendering
- some sort of `updateAll`|`deleteAll` ​functionality for controllers (array of ids)
- finalize resourceful controller actions (see https://github.com/josevalim/inherited_resources)
- error hooks for controllers
- test subdomains on heroku/nodejitsu
- switch to parsing url params with URI.js
- basic controller logging
- https helper methods
- http caching methods in the controller
- redirect helpers at the top level, so you easily write permanent redirects (http://stackoverflow.com/questions/4046960/how-to-redirect-without-www-using-rails-3-rack)
- namespaced controllers
- update to express 3.0

<a name="0.4.4" href="0.4.4"></a>

### 0.4.4 (models)

- basic model logging (so you can see things like database queries)
- remove dependency on mongodb
- uniqueness validation (database should not save a record unless specified attributes are globally unique (i.e. username))
- email/phone validation (and other common validation helpers)
- i18n (internationalization/​localization, how to organize the random labels in the app, and prepare for translation into other languages)
- strict! validation
- confirmation validation
- add includes to associations: `Post.includes("author").where(author: firstName: "=~": "Baldwin").all()`
- mongo url handler (https://github.com/viatropos/tower/issues/52#issuecomment-4586648)
- model indexes in mongodb (and potentially in memory, i.e. a redis-like plugin for the browser)
- test index creation in mongodb
- nested field queries ("addresses.city", etc.)
- mongo embedded documents
- test inheritance with type property
- `model#reload`
- acceptsNestedAttributes
- `find(id: null) # find by null`
- `where(name: "!=": "x")`
- `find(address: city: "San Diego") # nested doc/object queries`
- make `store` global, so you only have to apply it once, not per model.
  - makes testing easier.

<a name="0.4.5" href="0.4.5"></a>

### 0.4.5 (model extensions)

- authentication
- authorization
- add extension/module generator
- test storing images/blobs in mongo (GridFS?)
  - "Binary" data type?
  - http://blog.james-carr.org/2012/01/09/streaming-files-from-mongodb-gridfs/
- test storing images on s3
- get progress bar feedback for streaming file uploads
  - http://debuggable.com/posts/streaming-file-uploads-with-node-js:4ac094b2-b6c8-4a7f-bd07-28accbdd56cb
- image/asset/attachment model api (see https://github.com/​thoughtbot/paperclip)
- mass assignment security

<a name="0.4.6" href="0.4.6"></a>

### 0.4.6 (sockets)

- push notifications (web socket integration into the controllers)
- test client-side sockets
- swappable sockets api (sock.ly, socket.io)
- subscribe/notifications
  - http://railscasts.com/episodes/249-notifications-in-rails-3
  - pub/sub data through sockets

<a name="0.4.7" href="0.4.7"></a>

### 0.4.7 (background jobs, emails)

- background queuing with redis (`User.queue("welcome", 1)` vs. `User.welcome(1)`, for background processing) - https://github.com/technoweenie/coffee-resque
- Test the mailer (already implemented but needs tests)
- inline css in email templates
- https://github.com/voodootikigod/postmark.js

<a name="0.4.8" href="0.4.8"></a>

### 0.4.8 (helpers, configuration)

- add underscore helpers
  - pixel transforms  (px to em to percent to rem)
  - color transforms  (hsl to rgb to hex, etc.)
  - unit transforms   (miles to km, etc.)
  - geo transforms    (lat/lng to x/y in pixels, etc.)
  - date helpers
  - string helpers
  - number helpers
  - validators
  - masking input fields (phone numbers, social security, email, money, etc.)
- customize template engine, orm, and test framework in App.config
- create normalized file/directory api (wrench, pathfinder, findit... need to merge this stuff into one)

<a name="0.4.9" href="0.4.9"></a>

### 0.4.9 (cleanup, optimizations, documentation)

- autocomplete in the terminal (rubymine, node-inspector)
- autoreload in the console!
- chunk code into parts for the client, so you can use only bare minimum if desired
  - so you can do things like `require('tower-model')`
- finalize tower.js internal code organization
- design.io updates:
  - growl notifications
  - auto-run tests
- document code
- Add generator for translating different locales in tower.
- standardize `Tower.x` api for global helper methods.
- get design.io working on all platforms
  - remove ruby dependency if possible
  - make css @import compiler smarter
  - test and make sure it compiles all files on the first run
  - deleting/creating files isn't registering anymore, fix.

<a name="0.5.0" href="0.5.0"></a>

### 0.5.0 (theme)

- basic responsive admin theme, with functionality like http://activeadmin.info/
- client and server have the same interface, separate code out so client is as lean as possible
- make sure templates have proper escaping (xss protection)
- http://rails-admin-tb.herokuapp.com/admin/league

<a name="0.5.1" href="0.5.1"></a>

### 0.5.1 (benchmarking)

- cache manifest: https://github.com/johntopley/manifesto
- integrate `"use strict";` into the codebase if possible
- benchmarks folder with stress tests

## Separate plugins

- Make a mocha web console reporter.
- User stamping
- Versioning
- Advanced (lucene) search (down the road)

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

### Tower.Titanium

It's going to be very easy now to make Tower work with titanium mobile.  With coffeekup, you can have the form builder compile down to titanium objects no problem, something like:

``` coffeescript
App.View.helpers
  tabs: (options = {}) ->
    Titanium.UI.createTabGroup(options)
    
  tab: (options) ->
    options.window ||= @currentPane
    Titanium.UI.createTab(options)
    
  pane: (options, callback) ->
    @currentPane  = Titanium.UI.createWindow(options)
    callback()
```

``` coffeescript
tabs ->
  tab id: 'posts-tab', title: "Feed", ->
    pane title: "My Blog", ->
      table id: 'posts-table', data: App.Post.all()
```

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
- rails like flash messages
