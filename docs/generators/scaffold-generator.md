# Scaffold Generator

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
