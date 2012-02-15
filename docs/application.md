# Tower Application

``` coffeescript
class App extends Tower.Application
  @configure ->
    @use "favicon", Tower.publicPath + "/favicon.ico"
    @use "static", Tower.publicPath, maxAge: Tower.publicCacheDuration
    @use "profiler" if Tower.env != "production"
    @use "logger"
    @use "query"
    @use "cookieParser", Tower.cookieSecret
    @use "session", secret: Tower.sessionSecret, cookie: {domain: ".#{Tower.cookieDomain}"}, store: new MongoStore(mongostore)
    @use "bodyParser"
    @use "csrf"
    @use "methodOverride", "_method"
    @use Tower.Middleware.Agent
    @use Tower.Middleware.Location
  
    if Tower.httpCredentials && Tower.branch != "development"
      @use "basicAuth", Tower.httpCredentials.username, Tower.httpCredentials.password
    
    @use everyauth.middleware()
    @use Tower.Middleware.Router
  
module.exports = global.App = App
```

## Helpers

### Tower Helpers

``` coffeescript
Tower.url
Tower.get
Tower.post
Tower.put
Tower.delete
Tower.destroy
Tower.action
Tower.constant
```

### Underscore Helpers

``` coffeescript
_.stringify
_.camelize
_.parameterize
_.pluralize
_.singularize
_.humanize
_.titleize
_(2).days().fromNow().toDate()
```

## Reloading Changed Files

Internally Tower.js knows when a file was changed.  So when you refresh http://localhost:3000, it passes through the `Tower.Middleware.Dependencies` which re-requires any file that has changed.  This makes development uber fast, and prevents you from having to restart the server whenever a file changes (i.e. [nodemon](https://github.com/remy/nodemon)).  I mean, you can use nodemon if you want, it's a great project.  But you don't need to.