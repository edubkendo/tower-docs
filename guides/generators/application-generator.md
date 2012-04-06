# Application Generator

Tower comes with a full application skeleton generator similar to the Rails variant. 
To use the app generator, simply execute the following in a console.

```
tower new my-app
```

The generated application will have the following structure:

```
|-- app
|   |-- client
|   |   |-- stylesheets
|   |   |   `-- application.stylus
|   |   |-- config
|   |   |   `-- assets.coffee
|   |-- controllers
|   |   `-- applicationController.coffee
|   |-- models
|   |-- views
|   |   |-- layouts
|   |   |   `-- application.coffee
|   |   |-- index.coffee
|   `-- helpers
|   |   `-- applicationHelper.coffee
|-- Cakefile
|-- config
|   |-- application.coffee
|   |-- environments
|   |   |-- development.coffee
|   |   |-- production.coffee
|   |   `-- test.coffee
|   |-- locale
|   |   `-- en.coffee
|   |-- routes.coffee
|   |-- database.coffee
|-- lib
|-- package.json
|-- public
|   |-- favicon.ico
|   |-- humans.txt
|   `-- robots.txt
|-- README.md
|-- spec
|   |-- helper.coffee
|   |-- models
|   `-- acceptance
`-- vendor
|   |-- javascripts
|   |   |-- tower.js
|   |   |-- underscore.js
|   `-- stylesheets
`-- Watchfile
```

### Options for the `new` command:

The following options are currently supported:

```
--javascripts <format>  Format for JavaScripts (coffee, js)
--stylesheets <format>  Format for StyleSheets (styl, less, css)
--views <format>        Format for Views (coffee, jade, mustache)
--database <type>       Database type (mongodb, memory, sqlite3)
--test <framework>      Testing framework (jasmine, vows, qunit, assert)
--docs <format>         Documentation format (md, markdown, textile, txt)
-v, --version           Output the version number
-h, --help              Output usage information
```

In a future release Tower will likely support a `--locales` option.