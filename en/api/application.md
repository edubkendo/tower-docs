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
```

The `configure` function is used to configure the application.

* `favicon` points to the icon file displayed in the browser address bar.
* `static` is used to set where public (static) files reside and define their cache duration on the client.
* `profiler` is by default configured to only used only when the app is not in production mode (environment).

You can of course extend the configure function with your own application configuration logic as needed.
