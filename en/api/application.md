# Tower Application

The main application is defined in `config/application.coffee` and defaults to this:

```coffeescript
global.App = Tower.Application.create()
```
It is configured in 'config/bootstrap.coffee', which defaults to:

``` coffeescript
App.configure ->
  @use 'favicon', Tower.publicPath + '/favicon.png'
  @use 'static',  Tower.publicPath, maxAge: Tower.publicCacheDuration
  @use 'profiler' if Tower.env != 'production'
  @use 'logger'
  @use 'query'
  @use 'cookieParser', Tower.config.session.key
  @use 'session', secret: Tower.config.session.secret, cookie: {domain: Tower.config.session.cookie.domain}
  @use 'bodyParser', uploadDir: './public/uploads'
  #@use 'csrf'
  @use 'methodOverride', '_method'
  @use Tower.MiddlewareAgent
  @use Tower.MiddlewareLocation
  # if Tower.httpCredentials && Tower.branch != 'development'
  #   @use 'basicAuth', Tower.httpCredentials.username, Tower.httpCredentials.password

  @use Tower.MiddlewareRouter
```

The `configure` function is used to configure the application.

* `favicon` points to the icon file displayed in the browser address bar.
* `static` is used to set where public (static) files reside and define their cache duration on the client.
* `profiler` is by default configured to only used only when the app is not in production mode (environment).

You can of course extend the configure function with your own application configuration logic as needed.
