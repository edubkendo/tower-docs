# Session

Web sockets will work by creating a `Tower.Net.Connection` for each user.  Each connection will store an instance of each controller and actions the user has access to.  It will instantiate these controllers when first accessed using computed properties.  Then route matching the socket will act as if it's a request and pass through the controller action:

``` coffeescript
class Tower.Net.Connection
  # finds route, then passes to each connection
  @handle: (request) ->
    route = Tower.Route.find(request)
    return unless route

    for connection in @all
      connection.handle(route)

  @all: []

  constructor: (currentUser) ->
    @currentUser = currentUser

    @controllers

  # already has route matching, so it can update all connections
  handle: (request) ->

```

## Types of requests made in Web Sockets

There is a "store" and a "stream" or "connection".  The stream/connection defines how data is sent back and forth between client and server.  These include:

- Ajax
- Web Socket

Thus, a store has a connection.  Or more specifically, a store has a set of prioritized connections that fallback to less desirable methods of syncing data if the connection method is not available.  (Really, this means any database connection is just a property of a store).

### 1. Create a record

- Will pass through the already instantiated controller for the specific user, which is slightly more optimized, rather than an Ajax request that has to create a new controller for each request.
- Won't update all the connected clients if they have a cursor matching, because they should also be updated if there is a record created through the terminal, for example.  So it needs to be lower level.  Here's how that works.  When a record is modified (created/updated/deleted), it passes through all connections on the server and passes it through the matching connections' matching cursors.  On the client since there is only 1 connection it doesn't need the connection-cursor construct, just the cursor.

If a cursor is defined on a controller, it will ask the controller to match a record against its cursors rather than having the system internally just deal with the cursors.  This provides you a space to access the `currentUser`.

### 2. Create multiple records

Exactly the same as one, but it should bulk update each connection.  So if a `User` and `Post` are created in one transaction, it should send one request back to the client that looks something like this: `{users: [User], posts: [Post]}`.  If the connection doesn't allow a specific user to see that other users' posts, then there would be no update to that client.

### 3. Update a record

- controller scope
  - model scope
- after update
  - store
    - tower.net.connection
      - update
        - controllers
          - scopes
            - test
        - write to client
- client
  - create
    - connection
      - update (beginPropertyChanges)
        - controllers
          - scopes
            - test
        - write to server
          - callback with status and validation errors