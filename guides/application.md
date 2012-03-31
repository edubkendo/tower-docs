# Tower Application

The main application is defined in `config/application.coffee` and defaults to this:

``` coffeescript
class App extends Tower.Application
  @configure ->
    @use "favicon", Tower.publicPath + "/favicon.ico"
    @use "static",  Tower.publicPath, maxAge: Tower.publicCacheDuration
    @use "profiler" if Tower.env != "production"
    @use "logger"
    @use "query"
    @use "cookieParser", Tower.session.secret
    @use "session", Tower.session.key
    @use "bodyParser"
    @use "csrf"
    @use "methodOverride", "_method"
    @use Tower.Middleware.Agent
    @use Tower.Middleware.Location
    @use Tower.Middleware.Router

module.exports = global.App = App
```
