# Structure of a Tower.js Project

```
.
|-- app
|   |-- client
|   |   |-- stylesheets
|   |-- controllers
|   |   |-- admin
|   |   |   |-- postsController.coffee
|   |   |   `-- usersController.coffee
|   |   |-- commentsController.coffee
|   |   |-- postsController.coffee
|   |   |-- sessionsController.coffee
|   |   `-- usersController.coffee
|   |-- models
|   |   |-- comment.coffee
|   |   |-- post.coffee
|   |   `-- user.coffee
|   |-- views
|   |   |-- admin
|   |   |   `-- posts
|   |   |       |-- _form.coffee
|   |   |       |-- edit.coffee
|   |   |       |-- index.coffee
|   |   |       |-- new.coffee
|   |   |       |-- show.coffee
|   |   |-- layouts
|   |   |   `-- application.coffee
|   |   |-- shared
|   |   `-- posts
|   |       |-- index.coffee
|   |       `-- show.coffee
|   `-- helpers
|       |-- admin
|       |   |-- postsHelper.coffee
|       |   `-- usersHelper.coffee
|       `-- postsHelper.coffee
`-- config
|    |-- application.coffee
|    |-- assets.coffee
|    |-- databases.coffee
|    |-- preinitializers
|    |-- initializers
|    |-- environments
|       |-- development.coffee
|       |-- production.coffee
|       `-- test.coffee
|    |-- locale
|       `-- en.coffee
|    |-- routes.coffee
`-- test
|    |-- config.coffee
|    |-- models
|    |   |-- postTest.coffee
|    |   |-- userTest.coffee
|    `-- acceptance
|        |-- loginTest.coffee
|        |-- signupTest.coffee
|        `-- postsTest.coffee
```