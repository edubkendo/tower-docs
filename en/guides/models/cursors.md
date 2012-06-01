# `Tower.Model.Cursor`

Any of the finder or persistence methods that return an array are really returning a cursor.

## Resources

- http://en.wikipedia.org/wiki/Relational_algebra

## [Ideas/Todo]

``` coffeescript
# maybe `users` is a cursor, but it feels like an array, so you can do...
App.User.paginate (error, users) =>
  while users.hasNext
    for user in users
      console.log user.name
```
