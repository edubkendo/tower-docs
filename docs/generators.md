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

## Output

```
viatropos:test viatropos$ rails new test-app
      create  
      create  README
      create  Rakefile
      create  config.ru
      create  .gitignore
      create  Gemfile
      create  app
      create  app/assets/images/rails.png
      create  app/assets/javascripts/application.js
      create  app/assets/stylesheets/application.css
      create  app/controllers/application_controller.rb
      create  app/helpers/application_helper.rb
      create  app/mailers
      create  app/models
      create  app/views/layouts/application.html.erb
      create  app/mailers/.gitkeep
      create  app/models/.gitkeep
      create  config
      create  config/routes.rb
      create  config/application.rb
      create  config/environment.rb
      create  config/environments
      create  config/environments/development.rb
      create  config/environments/production.rb
      create  config/environments/test.rb
      create  config/initializers
      create  config/initializers/backtrace_silencers.rb
      create  config/initializers/inflections.rb
      create  config/initializers/mime_types.rb
      create  config/initializers/secret_token.rb
      create  config/initializers/session_store.rb
      create  config/initializers/wrap_parameters.rb
      create  config/locales
      create  config/locales/en.yml
      create  config/boot.rb
      create  config/database.yml
      create  db
      create  db/seeds.rb
      create  doc
      create  doc/README_FOR_APP
      create  lib
      create  lib/tasks
      create  lib/tasks/.gitkeep
      create  lib/assets
      create  lib/assets/.gitkeep
      create  log
      create  log/.gitkeep
      create  public
      create  public/404.html
      create  public/422.html
      create  public/500.html
      create  public/favicon.ico
      create  public/index.html
      create  public/robots.txt
      create  script
      create  script/rails
      create  test/fixtures
      create  test/fixtures/.gitkeep
      create  test/functional
      create  test/functional/.gitkeep
      create  test/integration
      create  test/integration/.gitkeep
      create  test/unit
      create  test/unit/.gitkeep
      create  test/performance/browsing_test.rb
      create  test/test_helper.rb
      create  tmp/cache
      create  tmp/cache/assets
      create  vendor/assets/stylesheets
      create  vendor/assets/stylesheets/.gitkeep
      create  vendor/plugins
      create  vendor/plugins/.gitkeep
         run  bundle install
         

viatropos:test-app viatropos$ rails g scaffold User email:string has_many:posts
      invoke  active_record
      create    db/migrate/20120113061643_create_users.rb
      create    app/models/user.rb
      invoke    test_unit
      create      test/unit/user_test.rb
      create      test/fixtures/users.yml
       route  resources :users
      invoke  scaffold_controller
      create    app/controllers/users_controller.rb
      invoke    erb
      create      app/views/users
      create      app/views/users/index.html.erb
      create      app/views/users/edit.html.erb
      create      app/views/users/show.html.erb
      create      app/views/users/new.html.erb
      create      app/views/users/_form.html.erb
      invoke    test_unit
      create      test/functional/users_controller_test.rb
      invoke    helper
      create      app/helpers/users_helper.rb
      invoke      test_unit
      create        test/unit/helpers/users_helper_test.rb
      invoke  assets
      invoke    coffee
      create      app/assets/javascripts/users.js.coffee
      invoke    scss
      create      app/assets/stylesheets/users.css.scss
      invoke  scss
      create    app/assets/stylesheets/scaffolds.css.scss
viatropos:test-app viatropos$ 
```