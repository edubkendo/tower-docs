# View Generator

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
