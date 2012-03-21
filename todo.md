# Todo

Tower is currently at version 0.3.9-x.  Going to move to 0.4.0 once it looks like everyone is able to build an app - just about there.

For 0.5.0, Tower will include the features below.  It's going to be a rolling list.  If you have ideas or features you'd like to see, include them in the section [Potential features for 0.5.0](#potential-features-0.5.0) section and we'll move them up if they're in scope.

Let me know if you'd like to implement any of these things, will help speed up the process.

<h2><a name="features-0.5.0" href="features-0.5.0">0.5.0 - Full Featured Release</a></h2>

- mongo embedded documents
- autosave association functionality
- test model pagination
- model indexes in mongodb (and potentially in memory, i.e. a redis-like plugin for the browser)
- test `factories` (something like [factory.js](https://github.com/viatropos/factory.js))
- test inheritance with `type` property
- acceptsNestedAttributesFor functionality
- background queuing with redis (`User.queue("welcome", 1)` vs. `User.welcome(1)`, for background processing)
- error/stacktrace printing when view fails to fully render
- auto-restart server when file changes (development)
- error hooks for controllers
- test subdomains on heroku
- database seeds
- extends hook for coffeescript
- get class methods/variables to clone from parent class (`extended` callback!).
  - extended callback doesn't look like it's going to be implemented, so see `Tower.metadata` for alternative.
- authentication extension (so it's easy to start using authentication, potentially with [passport](https://github.com/jaredhanson/passport))
- authorization extension (https://github.com/ryanb/cancan)
- test storing images/blobs in mongo
- test storing images on s3
- hasMany through associations (`Post.hasMany "comments"; Post.hasMany "commenters", through: "comments"`)
- uniqueness validation (database should not save a record unless specified attributes are globally unique (i.e. username))
- email/phone validation (and other common validation helpers)
- push notifications (web socket integration into the controllers)
- finish resourceful routes
- some sort of `updateAll|deleteAll` functionality for controllers (array of ids)
- finalize resourceful controller actions (see [https://github.com/josevalim/inherited_resources](https://github.com/josevalim/inherited_resources))
- switch to parsing url params with [URI.js](https://github.com/medialize/URI.js)
- urlFor helpers
- better controller rendering
- design.io updates:
  - growl notifications
  - auto-run tests
- mock/test setup for http requests (controllers)
- database "cleaner" code for tests
- generators for tests
- test the generator code
- customize template engine, orm, and test framework in `App.config`
- automatic form validations based on model on client
- test client side view rendering with coffeekup
- finish table builder
- i18n (internationalization/localization, how to organize the random labels in the app, and prepare for translation into other languages)
- underscore integration (cleanup/finalize, you easily spend a lot of your time formatting dates, numbers, and strings once the base app is in place):
  - date helpers
  - string helpers
  - number helpers
- Test the mailer (already implemented but needs tests)
- image/asset/attachment model api (see [https://github.com/thoughtbot/paperclip](https://github.com/thoughtbot/paperclip))
- basic model/controller logging
- basic responsive admin theme, with functionality like http://activeadmin.info/
- `tower generate authentication Session`
- client and server have the same _interface_, separate code out so client is as lean as possible
- chunk code into parts for the client, so you can use only bare minimum if desired
- cache manifest: https://github.com/johntopley/manifesto
- add `includes` to associations: `Post.includes("author").where(author: firstName: "=~": "Baldwin").all()`
- inline css in email templates
- http caching methods in the controller
- integrate `"use strict";` into the codebase
- css sprites
- `benchmarks` folder with stress tests
- https helper methods
- redirect helpers at the top level, so you easily write permanent redirects (http://stackoverflow.com/questions/4046960/how-to-redirect-without-www-using-rails-3-rack)
- make sure templates have proper escaping ([xss protection](http://asciicasts.com/episodes/204-xss-protection-in-rails-3))
- better url extraction in redirectTo
- clean up and test server-side responders, make sure JSON is the default
- set all class variables through the `Tower.metadata` object
- move all top-level random variables to `Tower.config`
- minimize the number of methods on `Tower.Application`, which is the namespace for your app
- set gzip headers for assets in production
- test the controller events
- add socket.io support
- test the sockets
- get tower to load multiple `taskname.cake` files (coffee-script doesn't support this)
- write tests for the command-line api
- merge https://github.com/pthrasher/kckr with design.io (or switch)

<h2><a name="potential-features-0.5.0" href="potential-features-0.5.0">Potential features for 0.5.0</a></h2>

- hierarchical models (nested sets)
- state machine (see [https://github.com/pluginaweek/state_machine](https://github.com/pluginaweek/state_machine))

<h2><a name="features-0.6.0+" href="features-0.6.0+">0.6.0+ Future Features</a></h2>

These are next, larger features.  These will be included in earlier releases if a member of the community contributes them.  Otherwise they will be more formally approached after the 0.5.0 release.

- Neo4j support
- CouchDB support
- PostGreSQL support
- MySQL support