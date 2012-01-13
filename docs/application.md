# Tower Application

``` coffeescript
class App extends Tower.Application
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
