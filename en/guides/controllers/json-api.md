# (todo/idea) JSON API

This isn't in there yet, but an idea.

Have a:

1. unified way of writing queries for the URL (`Tower.Controller.Params`)
2. unified way of modifying data on the client and server and through HTTP
3. unified way of querying data on the client and server and through HTTP

## Data Modifications

### `POST` to `/articles/10`

``` javascript
{
  "tags": {
    "$pushEach": ["ruby", "javascript"]
  }
}
```

Probably don't need this b/c it's going to have to validate it on the server anyway.

## Data Queries

### `POST` to `/articles`

``` javascript
{
  "where": {
    "tags": {
      "$in": ["ruby", "javascript"]
    }
  },
  "sort": [
    ["createdAt", "desc"]
  ],
  "page": 2
}
```

### Response

``` javascript
{
  "data": [
    {"id": 20, "title": "20th Post"},
    {"id": 22, "title": "21st Post"},
    ...
  ],
  "where": {
    "tags": {
      "$in": ["ruby", "javascript"]
    }
  },
  "sort": [
    "createdAt-"
  ],
  "count": 20,
  "totalCount": 750,
  "page": 2,
  "pageCount": 38
}
```

We may want to prevent a response as well, which we can do in some cases, like when everything's being updated through web sockets.  Will save on processing.

We may also need to store other metadata with the request, such as `ids`.  A request might be based on the users current location, and be paginated, so we may want to cache the record ids matched with the initial query so pagination is still making sense.  This also makes it so subsequent queries won't have to make the database call, it can just use ids.

## Batch Requests

### `POST` to `/articles/batch`

``` javascript
{
  "data": [
    {
      "method": "POST",
      "url": "/articles",
      "post": {
        "title": "New Post!"
      }
    },
    {
      "method": "DELETE",
      "url": "/articles",
      "id": 19
    }
  ]
}
```

## Security

We will also need a way to prevent certain actions based on the `currentUser`.  For example, you don't want a user to `POST` this to `/users`:

``` javascript
{
  "roles": {
    "$addEach": ["guest", "admin"]
  }
}
```

So, this JSON api should probably be disabled by default.  Then you can selectively allow these type of "atomic operations" in the model.

``` coffeescript
class App.User extends Tower.Model
  @accessible 'roles', as: 'admin'
```

Then in the controller, you can scope variable mass assignment by the current user's role:

``` coffeescript
class App.UsersController extends App.ApplicationController
  create: ->
    user = App.User.new(@params.user, as: @currentUser.get('role'))
```

Perhaps you should also be able to manage it at a lower level, on a per-atomic-operation level:

``` coffeescript
class App.User extends Tower.Model
  @accessible 'roles', as: 'admin'
  @accessible {roles: ['$remove', '$removeEach']}, as: 'default'
```