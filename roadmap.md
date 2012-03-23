## Near Future

- Finish the initializer process
- Add file uploading support
- **Embedded Documents in MongoDB**
- Autoreload js/coffee files when they change (without restarting the server with something like [nodemon](https://github.com/remy/nodemon))
- **Break the client library into small modules**, with the tower.core.js being ideally <= 10k.  So you start with just barebones functionality (model layer), then you can add controllers, then views, one piece at a time if you want.  The default tower.js will include everything.
- Probably going to want to divide the client/server implementation into more clearly separated chunks.  From a "building an app" perspective, you won't know the different, it'll just work - they'll have the same api.  But from an implementation perspective, they should probably be separate projects.  This way the client can be as lean and mean as possible, to minimize download size, while the server can be robust like Rails.
- **Logging**.  Just put debug/info level logging throughout the http/database calls like Rails so you can see what's going on in a standard way.
- Make socket.io a plugin to the framework, not a default dependency.
- Setup [zombie](https://github.com/assaf/zombie) tests internally to test tower's client side implementation.
- **Consider data binding/event dispatching**.  [Just ideas]. Consider integrating ember.metal.js into the base tower model and scope objects (opt-in of course).  This way you could take advantage of ember.js views in tower models.  I first want to really test performance with ember.js, after years of Adobe Flex I'm very resistant to data-binding...  Even though you write a lot less code, the amount of memory that data binding uses up, and the tons of additional calculations it does whenever anything changes, makes even simple apps SLOW.  I am not okay with slowness.  Also, data-binding is an abstraction layer that, while making the beginning developer move very fast initially, makes the simple impossibly hard the intermediate and advanced developer who just wants to make "this" happen when an a data binding is triggered, vs. "that".  It becomes a black box that's impenetrable, and it comes with a significant performance loss.  I need to run tests a) to see if data binding has near equal performance as manually the writing code on a one-off basis, and b) to see if the amount of time you save by having data binding abstracted away is greater than the amount of time you spend manually writing the code on a per-app basis.  I've always thought manually writing the code, while tedious, is easy code to write - and you have total control over performance which is key b/c this is all UI.
- Test out the mailer with sendgrid, and integrate inline css.
- Build redis/resque into an `enqueue` module.
- Build a _lightweight but powerful_ hierarchical relationship manager (https://github.com/collectiveidea/awesome_nested_set) (directed acyclic graph).
- add namespaces to global app when you generate a namespaced scaffold
- Consider `require()` in the browser.  My main concern with this is there needs to be a super light "standard" library for this, that everybody's using.  Why doesn't this exist yet?  Once it does, and it's a common name like `underscore.js`, and it's _lightweight_ ([requirejs](https://github.com/jrburke/requirejs) is not lightweight), then we'll potentially start using this standard.
- Finish the I18n implementation
- Integrate (or give examples of) a date parsing library like moment.js.
- Refactor the `Tower.Model.Scope` calculations into an algorithm (if there is one, similar to [Arel](https://github.com/rails/arel))
- Integrate [URI.js](http://medialize.github.com/URI.js/) server-side.
- Benchmark
- Write the best tests in the world
- To decrease app startup time, you might be able to write some sort of method missing functionality in javascript as follows: When you call `App.Post`, and `require('./app/models/post')` has not been called, it inspects the `error.stack` to figure out "oh, 'Post' was called on 'App'", and then knows how to find it.  This way you wouldn't have to pollute your app with `require` for every single model call, but could also lazy load models/controllers/etc.  Wrap the whole app in a try/catch block and inspect function calls recursively, something like that.  Just an idea.
- Authentication example
- Authorization plugin like https://github.com/ryanb/cancan

## Further Future

- Generating generators: http://asciicasts.com/episodes/218-making-generators-in-rails-3
- https://github.com/gregbell/active_admin
- https://github.com/sferik/rails_admin
- have [exceptional](http://www.exceptional.io/) and [newrelic](http://newrelic.com/) style logging
- sharding and replication (scaling) should all be built in to some degree: https://github.com/tchandy/octopus, https://www.ruby-toolbox.com/categories/Active_Record_Sharding
- calculate age
- autoincrement id in mongodb
- download csv node.js express

## Test on node.js hosting platforms

- https://no.de/ (paid)
- http://nodester.com (free)
- http://heroku.com (free)
- http://www.webbynode.com/ (paid)
- http://nodejitsu.com (private)
- http://docs.dotcloud.com/services/nodejs/ (free)