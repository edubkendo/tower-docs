# Feature Ideas

## Controller Ideas

It might be cool to get rid of having to call things like `@params` and `@currentUser` all the time, just call `params`.  We'd need to somehow define local variables dynamically.  Only if it doesn't come at a performance cost.

## Transactions

``` coffeescript
Tower.transaction (transaction) =>
  _.series [
    (next) => App.User.with(transaction).create(next)
    (next) => App.Post.with(transaction).create(next)
  ], (error) =>
    transaction.commit()
```

Or perhaps the transaction prevents any persistence from occurring until the end?

``` coffeescript
Tower.Store.transaction (transaction) =>
  user = App.User.with(transaction).create()
  user = transaction.adopt(App.User).create()
  post = new App.Post
  transaction.adopt(post)
  post.with(transaction)
  
  transaction.commit (error) =>
    
```

Problems with this are that you can't get a realistic snapshot of the user/post objects, since they haven't been persisted.  And it's a different programming paradigm.

When you save a dirty model, it takes a snapshot of the changes.  This makes it so you can still change the attributes, but anything after that `model.save()` call won't be passed to the database (if it's async).

