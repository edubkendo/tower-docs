# Todo

The documentation site will be basically like this (organization/readability wise): [http://mongoid.org/](http://mongoid.org/).  That site always gets raved about for how easy it makes learning MongoDB for Rails.

## Main Chunks

- hasMany through associations (`Post.hasMany "comments"; Post.hasMany "commenters", through: "comments"`)
- polymorphic associations (`Category.belongsTo "categorizable", polymorphic: true`)
- uniqueness validation (database should not save a record unless specified attributes are globally unique (i.e. username))
- email/phone validation
- push notifications (web socket integration into the controllers)
- controller events
- client controllers
- client controller dom event api
- switch to parsing url params with [URI.js](https://github.com/medialize/URI.js)
- design.io updates:
  - auto-restart server
  - growl notifications
  - auto-run tests
- test http requests (controllers)
- database "cleaner" code for tests
- asset builder (remove from rituwall Cakefile)
- generators (generates project skeleton, model/view/controller base templates, or a node module base template)
- form builder
- automatic form validations based on model
- client side view rendering with coffeekup
- table builder
- state machine (see [https://github.com/pluginaweek/state_machine](https://github.com/pluginaweek/state_machine))
- i18n (internationalization/localization, how to organize the random labels in the app, and prepare for translation into other languages)
- underscore integration (cleanup/finalize, you easily spend a lot of your time formatting dates, numbers, and strings once the base app is in place):
  - date helpers
  - string helpers
  - number helpers
- History.js (or equivalent) integration into client controller
- Async integration (callbacks)
- Test the mailer (already implemented but needs a few tests)
- Command line api for generators
- test with travis ci
