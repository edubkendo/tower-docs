# Models on the Client

When you're on the client, you have three options on where to store the data defined by your models:

- `Tower.Store.Memory`: in memory
- `Tower.Store.LocalStorage`: in the browser (via local storage)
- `Tower.Store.Ajax`: on the server (via ajax)

You can specify a default store like this:

``` coffeescript
Tower.Model.default('store', Tower.Store.Ajax)
```

You can swap out stores dynamically on a per-class basis as well:

``` coffeescript
class App.User extends Tower.Model
  @defaultStore = Tower.Store.Memory

App.User.create() # save in memory
App.User.store(Tower.Store.Ajax)
App.User.create() # save with ajax
```
