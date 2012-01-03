# Generators

## New Application Generator

```
tower new my-app
```

Your new application:

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

## Scaffold Generator

```
tower generate scaffold Post title:string body:text belongsTo:user
```

Generates:

```
|-- app
|   |-- controllers
|   |   |   `-- usersController.coffee
|   |-- models
|   |   |   `-- user.coffee
|   |-- views
|   |   |-- users
|   |   |   `-- _form.coffee
|   |   |   `-- edit.coffee
|   |   |   `-- index.coffee
|   |   |   `-- new.coffee
|   |   |   `-- show.coffee
|   `-- helpers
|   |   |   `-- userHelper.coffee
`-- spec
|    |-- models
|   |   |   `-- userSpec.coffee
```

## Model Generator

```
tower generate model Post title:string body:text belongsTo:user
```

Generates:

```
|-- app
|   |-- models
|   |   |   `-- user.coffee
```

## View Generator

```
tower generate view Post title:string body:text belongsTo:user
```

Generates:

```
|-- app
|   |-- views
|   |   |-- users
|   |   |   `-- _form.coffee
|   |   |   `-- edit.coffee
|   |   |   `-- index.coffee
|   |   |   `-- new.coffee
|   |   |   `-- show.coffee
```

## Controller Generator

```
tower generate controller Post
```

Generates:

```
|-- app
|   |-- controllers
|   |   |   `-- usersController.coffee
```