# Todo

Tower is currently at version 0.3.9-x.  Going to move to 0.4.0 once it looks like everyone is able to build an app - just about there.

For 0.5.0, Tower will include the features below.  It's going to be a rolling list.  If you have ideas or features you'd like to see, include them in the section [Potential features for 0.5.0](#potential-features-0.5.0) section.

<h2><a name="features-0.5.0" href="features-0.5.0">0.5.0 - Full Featured Release</a></h2>

- mongo embedded documents
- error/stacktrace printing when view fails to fully render
- auto-restart server when file changes (development)
- error hooks for controllers
- test subdomains on heroku
- database seeds
- authentication extension
- authorization extension (https://github.com/ryanb/cancan)
- test storing images/blobs in mongo
- test storing images on s3
- hasMany through associations (`Post.hasMany "comments"; Post.hasMany "commenters", through: "comments"`)
- polymorphic associations (`Category.belongsTo "categorizable", polymorphic: true`)
- test model pagination
- uniqueness validation (database should not save a record unless specified attributes are globally unique (i.e. username))
- email/phone validation (and other common validation helpers)
- push notifications (web socket integration into the controllers)
- background queuing with redis (`User.queue("welcome", 1)` vs. `User.welcome(1)`, for background processing)
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
- generators (generates project skeleton, model/view/controller base templates, or a node module base template)
- automatic form validations based on model on client
- test client side view rendering with coffeekup
- finish table builder
- state machine (see [https://github.com/pluginaweek/state_machine](https://github.com/pluginaweek/state_machine))
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

<h2><a name="potential-features-0.5.0" href="potential-features-0.5.0">Potential features for 0.5.0</a></h2>

