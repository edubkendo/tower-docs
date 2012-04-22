# Transactions

Tower models have something like database transactions.

On the client, there is one global transaction.  By default, this transaction commits every time you create/save/update/destroy a record.  You can set `Tower.Store.Transaction.commitInterval = n` to some `n` millisecond value, and it will make sure the transaction is committed every `n` milliseconds.  If it's `0`, it will commit automatically.  You can also set it to `null` and it will never commit, you have to manually call `Tower.Store.instance().commit()`.

On the server, there is no global transaction; that would create a huge memory management problem.  Instead, every create/save/update/destroy creates its own transaction and automatically commits.  If you want group multiple operations into a single transaction, you can do that like this:

``` coffeescript
class App.TransactionsController extends Tower.Controller
  create: ->
    Tower.Store.transaction (transaction) =>
      user = App.User.with(transaction).create()
      post = App.Post.with(transaction).create()
      transaction.commit (error) =>
        if error
          @render json: success: "All operations saved"
        else
          @render json: failure: error.message
```

The model instances themselves will always show their new/updated attribute values, but they won't necessarily get their `id` immediately due to the async database operations.

## Scopes

### Creating Records

``` coffeescript
App.User.where(firstName: "Lance").create()
  cursor.create() # pass in transaction if cursor had transaction
    record.save()
      transaction.create()
        if transaction.autocommit
          store.create()
          
user = new App.User

user.save()
  transaction.create()
    store.create()
    
App.User.create({}, {}, {})
  cursor.create()
    for record in records
      record.save()
        transaction.create()
          store.create()
          
App.User.transaction().create({}, {}, {})
  cursor.create()
    for record in records
      record.save()
        transaction.create()
    transaction.commit()
      store.create()
```

### Finding Records (bindable scopes)

`scope.all` returns a cursor, so if you want the records you have to add a callback `scope.all (error, records)`.  This makes it so you can do both/or: get the records or set up a binding to that record set.

``` coffeescript
# this returns a cursor that acts like an array of records.
App.usersByFirstName = App.User.asc("firstName").limit(20).all()
# this returns a cursor that acts as an individual record.
# this way you can have something like a "featured post"
# that will automatically update. Maybe we don't want to do this.
App.topPost = App.Post.desc("likes").first()
```

```html
<ul>
{{#each App.usersByFirstName}}
  <li>{{fullName}}</li>
{{/each}}
</ul>
```

Ideally you'd be able to not have to call `all`, so you could do this:

``` coffeescript
class App.User extends Tower.Model
  @field "firstName"
  
  @scope "byFirstName", @asc("firstName").limit(20)
```

``` coffeescript
<ul>
{{#each App.User.byFirstName}}
  <li>{{fullName}}</li>
{{/each}}
</ul>
```

### List of "checkins within the last minute"

Since the `>=` is a `Date`, Tower will generate a callback which will update the query with the latest records.  By default it will update it every 5 seconds, but you can change this.

``` coffeescript
App.latestCheckins = App.Checkin.where(createdAt: ">=": _(1).minute().ago()).all()

App.Checkin.create()
# wait 0:50
App.Checkin.create()
# wait 0:11, 1 checkin disappears.
```

```html
<ul>
{{#each App.lastCheckins}}
  <li>{{user.name}} checked into {{place.name}} at {{createdAtAgo}}</li>
{{/each}}
</ul>
```

- If `Date`, refresh every x interval.

### List of "closest"

``` coffeescript
currentLocation   = [40.741404,  -73.988135]
App.closestDeals  = App.Deal.near(currentLocation).within(1, "mile").all()
```

```html
<ul>
{{#each App.closestDeals}}
  <li>{{description}}</li>
{{/each}}
</ul>
```

That `currentLocation` will be a bindable array, which when updated will update the scope, so the deals always reflect the ones closest the current location!

- If location, refresh if location changes
- If array, refresh if array changes.

### CoffeeKup to generate handlebar templates

Potential idea!

``` coffeescript
ul ->
  each "App.closestDeals", ->
    li "{{description}}"
```
