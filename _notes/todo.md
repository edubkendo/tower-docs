# Todo

The documentation site will be basically like this (organization/readability wise): [http://mongoid.org/](http://mongoid.org/).  That site always gets raved about for how easy it makes learning MongoDB for Rails.

## Blocks of Functionality I'd Work On At Once

- **Underscore helpers**: Make the string formatting functionality robust, this is a huge pain right now.  Same with Dates, I haven't even really touched dates.
- **Associations**: Need to spend a few days testing these out, I need basically a test Blog app to test all the features haha.
- **Resourceful Controllers**: Param parsing, model pagination/searching, bulk updates/deletes, `belongsTo` in the controller.
- **Controller Events**: Web sockets, dom events, and client side rendering
- **View Helpers**: Form/table builder (makes testing models easier, and makes building new apps insanely easy).  And makes things semantic
- **Logging**
- **Design.IO**: Watchfile updates, growl, server auto-restart, etc.
- **Internationalization**
- **Generators**: And the command line interface

## Broken down into more specific chunks

- hasMany through associations (`Post.hasMany "comments"; Post.hasMany "commenters", through: "comments"`)
- polymorphic associations (`Category.belongsTo "categorizable", polymorphic: true`)
- support async integration (callbacks)
- async model callbacks
- test model pagination
- uniqueness validation (database should not save a record unless specified attributes are globally unique (i.e. username))
- email/phone validation
- push notifications (web socket integration into the controllers)
- background queuing with redis (`User.queue("welcome", 1)` vs. `User.welcome(1)`, for background processing)
- controller events
- client controllers
- client controller dom event api
- client-side sync methods
- finalize resourceful routes
- some sort of `updateAll|deleteAll` functionality for controllers (array of ids)
- finalize resourceful controller actions (see [https://github.com/josevalim/inherited_resources](https://github.com/josevalim/inherited_resources))
- switch to parsing url params with [URI.js](https://github.com/medialize/URI.js)
- urlFor helpers
- better controller rendering
- controller renderer
- controller params parser
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
- Test the mailer (already implemented but needs a few tests)
- Command line api for generators
- test with [travis ci](http://about.travis-ci.org/)
- image/asset/attachment model api (see [https://github.com/thoughtbot/paperclip](https://github.com/thoughtbot/paperclip))
- basic model/controller logging
- whip together a site USING TOWER AND THE TOWER APP GENERATOR
- [PUBLIC RELEASE](http://towerjs.org)

- basic responsive admin theme
- syntax highlighting for github-style code
- tower generate authentication Session

- client and server have the same _interface_
- cache manifest: https://github.com/johntopley/manifesto

``` coffeescript
# hasMany "comments", through: "posts"
comments  = user.comments().where(message: /(javascript)/).limit(10).all()

# eager load associations
Post.includes("author").where(author: firstName: "=~": "Baldwin").all()
Post.includes("author").where("author.firstName": "=~": "Baldwin").all()
User.includes("posts").where("posts.title": "Welcome").all()
```

## Collections

Need a better way to handle $push, $pop, etc.

Maybe:

``` coffeescript
set: (options) ->
  if options.$push
    for key, value of options.$push
      oldValue = @attributes[key]
      newValue = oldValue.concat().push(value)
      @changes[key] = [@attributes[key], newValue, value] # [old, new, diff]
```

The above will give you a way of being notified when any attribute changes.

## Events on Scopes

``` coffeescript
scope = User.where(active: true)
scope.on "create"
scope.on "update"
scope.on "destroy"
```

The problem with the above approach is if you had 10 scopes all with these event handlers, you'd have to iterate through all of them every time a model was added, even though the model may have matched the first scope only (technically several scopes might match a given record).

It's probably easier/clearer to just listen to any model that's added and manually check:

``` coffeescript
scope = User.where(active: true)
User.on "create", (error, model) ->
  if scope.contains(model)
    # ...
```

- http://stackoverflow.com/questions/1992902/add-new-gist-using-the-github-api
- https://github.com/emerleite/node-gist
- Integration with Ember.js on client?
- Hardcore event dispatching framework?