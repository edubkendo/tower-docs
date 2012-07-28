# Model Generator

```
tower generate model Post title:string body:text belongsTo:user
```

Generates:

```
|-- app
|   |-- models
|   |   |   `-- post.coffee
```

The Post model generated:

```coffeescript
class App.Post extends Tower.Model
  @field "id", type: "Id"
  @field "title"
  @field "body"
  @belongs_to "user", type: "User", foreignKey: "userId"
  @field "createdAt", type: "Time", default: -> new Date()
```