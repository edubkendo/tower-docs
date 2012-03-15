# Watchfile

Tower uses [design.io](https://github.com/viatropos/design.io)'s `Watchfile` to:

- Automatically compile assets when they are added, saved, or removed.  See the [Tower Asset Pipeline](/assets/pipeline)
- Automatically restart the server in development mode when you modify a file
- Push compiled CSS and JavaScripts to the browser as you're developing without refreshing the browser!
- Automatically run tests across browsers, platforms, and devices as your developing.
- Give you space to add more `watch` tasks to streamline workflow

## Default Watchfile

``` coffeescript
require('design.io').extension('watchfile')

require("design.io-stylesheets")
  compress: false
  ignore: /(public|node_modules)/
  paths:  File.directories("app/assets").concat File.directories("themes")
  write: (path, string) ->
    path = "public/stylesheets/#{path}".replace(/\.(css|styl|less)/, ".css")
    try
      File.write path, string, (error) ->
        console.log(error.stack) if error
    catch error
      console.log error.stack
      
require("design.io-javascripts")
  compress: false
  debug:    false
  ignore:   /(public|node_modules|server|spec.*[sS]pec)/
  #outputPath: (path) ->
  #  "spec/tmp/test.css"
  write: (path, string) ->
    path = "public/javascripts/#{path}".replace(/\.(js|coffee)/, ".js")
    #growl.notify("updated #{path}", { title: 'Stylesheets' })
    try
      File.write path, string, (error) ->
        console.log(error.stack) if error
    catch error
      console.log error.stack
      
# update .coffee file when .mustache file of same name changes      
watch /app\/views.*\.mustache/
  update: (path, callback) ->
    coffeePath = path.replace(".mustache", ".coffee")    
    LOG coffeePath
    if File.exists coffeePath
      File.touch coffeePath      
    callback()
```
