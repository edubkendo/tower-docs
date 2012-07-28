# Deploying to Nodejitsu

Delete design.io in devDependencies as it will cause an issue. This issue has been flagged by nodejitsu.

Put this at the top of config/application.coffee:

``` coffeescript
if process.env.NODE_ENV == 'production'
  Tower.Application::watch = ->
  Tower.env = 'production'
```
