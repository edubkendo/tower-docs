# Todo

Tower is currently at version 0.3.9-x.  Going to move to 0.4.0 once it looks like everyone is able to build an app - just about there.

For 0.5.0, Tower will include the features below.  It's going to be a rolling list.  If you have ideas or features you'd like to see, include them in the section [Potential features](#potential-features) section and we'll move them up if they're in scope.

Let me know if you'd like to implement any of these things, will help speed up the process.

<a name="features-0.5.0" href="features-0.5.0"></a>

## 0.5.0 - Full Featured Release

### 0.4.0

-  switch to parsing url params with URI.js
-  urlFor helpers
-  Extend helper method urlFor so that can it resolve to registered paths (aliases) for routes 
  -  urlFor 'Log on', :route => 'sign_in'
  -  urlFor 'Log on',  'sign_in_path'
-  auto-restart server when file changes (development)
-  database seeds
-  better controller rendering

### 0.4.1

-  extends hook for coffeescript
-  mongo embedded documents
-  test factories (something like factory.js)
-  underscore integration (cleanup/finalize, you easily spend a lot of your time formatting dates, numbers, and strings once the base app is in place)
 	- date helpers, string helpers, number helpers

### 0.4.2

-  some sort of updateAll|deleteAll ​functionality for controllers (array of ids)
-  finish resourceful routes
-  i18n (internationalization/​localization, how to organize the random labels in the app, and prepare for translation into other languages)

### 0.4.3

-  uniqueness validation (database should not save a record unless specified attributes are globally unique (i.e. username))
-  email/phone validation (and other common validation helpers)
-  automatic form validations based on model of client
-  test client side view rendering with coffeekup
-  basic model/controller logging

### 0.4.4

-  test inheritance with type property
-  finalize resourceful controller actions (see https://github.com/​josevalim/inherited_resources)
-  error/stacktrace printing when view fails to fully render
-  error hooks for controllers

### 0.4.5

-  test storing images/blobs in mongo
-  test storing images on s3
-  test subdomains on heroku
-  hasMany through associations (Post.hasMany "comments"; Post.hasMany "commenters", through: "comments")

### 0.4.6

-  push notifications (web socket integration into the controllers)
-  background queuing with redis (User.queue("welcome", 1) vs. User.welcome(1), for background processing)
-  test model pagination

### 0.4.7

-  mock/test setup for http requests (controllers)
-  generators for tests
-  test the generator code
-  customize template engine, orm, and test framework in App.config

### 0.4.8

-  Test the mailer (already implemented but needs tests)
-  image/asset/attachment model api (see https://github.com/​thoughtbot/paperclip)
-  add includes to associations: Post.includes("​author").where(author: firstName: "=~": "Baldwin").all()
-  model indexes in mongodb (and potentially in memory, i.e. a redis-like plugin for the browser)

### 0.4.9

-  design.io updates:
  -  growl notifications
  -  auto-run tests
-  database "cleaner" code for tests
-  finish table builder
-  inline css in email templates
-  http caching methods in the controller
-  https helper methods

### 0.5.0

-  basic responsive admin theme, with functionality like http://activeadmin.info/
-  client and server have the same interface, separate code out so client is as lean as possible
-  make sure templates have proper escaping (xss protection)

### 0.5.1

-  chunk code into parts for the client, so you can use only bare minimum if desired
-  cache manifest: https://github.com/​johntopley/manifesto
-  integrate "use strict"; into the codebase
-  css sprites
-  benchmarks folder with stress tests
-  redirect helpers at the top level, so you easily write permanent redirects (http://stackoverflow.com/​questions/4046960/how-to-​redirect-without-www-using-​rails-3-rack)

## Separate plugins

### TowerPassport

-  authentication extension (so it's easy to start using authentication, potentially with passport
-  tower generate authentication Session

### TowerCanDo

-  authorization extension (https://github.com/ryanb/​cancan)

## Support for alternative data stores (as plugins) 

These are next, larger features.  These will be included in earlier releases if a member of the community contributes them.  Otherwise they might be approached after the 0.5.0 release according to community requests.

- Neo4j support
- CouchDB support
- (PostGreSQL support ?)
- (MySQL support ?)

<a name="potential-features" href="potential-features"></a>

## Potential Features

- hierarchical models (nested sets)
- state machine (see [https://github.com/pluginaweek/state_machine](https://github.com/pluginaweek/state_machine))