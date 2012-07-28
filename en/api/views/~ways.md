## Building a filtered list

### Plain jQuery

``` coffeescript
# view
section id: 'posts-section', ->
  input type: 'text'
  ul ->
    for post in @posts
      li class: 'post', 'data-id': post.get('id').toString(), 'data-tags': post.get('tags').toString(), ->
        a title: post.get('title'), href: '#', post.get('title')
  
# controller
class App.PostsController extends Tower.Controller
  @on 'keyup #posts-section input', 'filter'
  
  # or you can try to wire in the jQuery.liveUpdate plugin
  filter: (event) ->
    value = $(event.currentTarget).val().toLowerCase()
    rows  = $('#posts-section ul li')
    rows.hide()
    for row in rows
      tags = row.attr('data-tags')
      if tags.match(value)
        rows.show()
```

In this case we're storing the data in the DOM, so you don't ever really need to access the model via `App.Post.all()`.

One issue with this is you have to have a special function to add or remove an item to/from the list.  In the Ember.js version you get that for free.

### Ember.js

``` coffeescript
# view
section id: 'posts-section', ->
  input '{{action "filter" on="keyup" target="App.postsController"}}', type: 'text'
  ul ->
    hEach 'App.postsController.all', ->
      li class: 'post', ->
        a title: '{{title}}', href: '#', '{{title}}'

# controller
class App.PostsController extends Tower.Controller
  all: App.Post.publish().all()
  
  filter: (event) ->
    # or even better (todo), update the criteria
    @set 'all', App.Post.where(tags: '=~': $(event.currentTarget).val())
```

In this case, Ember takes care of mapping the model to the DOM in the background, so from your perspective you only need to deal with the model.

However, that `{{action}}` tag makes it look like there's some logic in the view.  I would remove that and put it into the controller:

``` coffeescript
# view
section id: 'posts-section', ->
  input type: 'text'
  ul ->
    hEach 'App.postsController.all', ->
      li class: 'post', ->
        a title: '{{title}}', href: '#', '{{title}}'

# controller
class App.PostsController extends Tower.Controller
  @on 'keyup #posts-section input', 'filter'

  all: App.Post.publish().all()
  
  filter: (event) ->
    # or even better (todo), update the criteria
    @set 'all', App.Post.where(tags: '=~': $(event.currentTarget).val())
```

An additional benefit you get from putting event handlers into the controller rather than the markup is Ember doesn't need to parse and build an event handler every time you recreate this view.  Instead, the event handler is registered at the beginning once.

## Building a sorted table

### Plain jQuery

``` coffeescript
# view
tableFor 'users', (t) ->
  t.head ->
    t.row ->
      t.header 'First Name'
      t.header 'Last Name'
      t.header 'Email'
  t.body ->
    for user in @users
      t.row class: 'user', 'data-id': user.get('id').toString(), ->
        t.cell user.get('firstName')
        t.cell user.get('lastName')
        t.cell user.get('email')

# controller
class App.UsersController extends Tower.Controller
  @on 'click thead th', 'sort'
  
  sort: (event) ->
    index = $(event.currentTarget).index()
    
    rows  = $('tbody tr')
    rows.sort (a, b) ->
      # some sorting function, don't know exactly
      $('td', a).text() <= $('td', b).text()
```

- you need to store the `id` somewhere, so we're storing it in the table row.

### Ember.js

``` coffeescript
# view
tableFor 'users', (t) ->
  t.head ->
    t.row ->
      t.header 'First Name'
      t.header 'Last Name'
      t.header 'Email'
  t.body ->
    hEach 'App.usersController.all', ->
      t.row class: 'user', ->
        t.cell '{{firstName}}'
        t.cell '{{lastName}}'
        t.cell '{{email}}'

# controller
class App.UsersController extends Tower.Controller
  @on 'click thead th', 'sort'
  
  all: App.User.all()
  
  sort: (event) ->
    attribute = $(event.currentTarget).attr('data-attribute')
    
    # should actually just resort the current criteria
    # so it doesn't recreate all the views
    @set 'all', App.User.order(attribute).all()
```

## Building a paginated table

### Plain jQuery

``` coffeescript
# view
tableFor 'users', (t) ->
  t.head ->
    t.row ->
      t.header 'First Name'
      t.header 'Last Name'
      t.header 'Email'
  t.body ->
    for user in @users
      t.row class: 'user', 'data-id': user.get('id').toString(), ->
        t.cell user.get('firstName')
        t.cell user.get('lastName')
        t.cell user.get('email')
  t.foot ->
    nav class: 'pagination', ->
      ul ->
        a class: 'first', 'data-page': 'first', href: '#', 'First'
        a class: 'prev', 'data-page': 'prev', href: '#', 'Previous'
        a class: 'next', 'data-page': 'next', href: '#', 'Next'
        a class: 'last', 'data-page': 'last', href: '#', 'Last'

# controller
class App.UsersController extends Tower.Controller
  @on 'click table .pagination a', 'paginate'
  
  paginate: (event) ->
    link            = $(event.currentTarget)
    currentPage     = @currentPage ||= 1
    totalPages      = @totalPages || 1
    
    page  = switch link.attr('data-page')
      when 'first' then 1
      when 'prev' then Math.max(currentPage - 1, 1)
      when 'next' then Math.min(currentPage + 1, totalPages)
      else totalPages
    
    App.User.page(page).fetch (error, users) =>
      @set 'users', users
      @render
```

You could also register one event handler per listener:

``` controller
class App.UsersController extends Tower.Controller
  @on 'click .pagination .first', 'first'
  @on 'click .pagination .prev', 'prev'
  @on 'click .pagination .next', 'next'
  @on 'click .pagination .last', 'last'
```

### Ember.js

Not much changes here other than using the Handlebars markup.  The complexity lies in the pagination logic, but once you have the set of models you need you can update your views like the sorting example above.

``` coffeescript
# view
tableFor 'users', (t) ->
  t.head ->
    t.row ->
      t.header 'First Name'
      t.header 'Last Name'
      t.header 'Email'
  t.body ->
    hEach 'App.usersController.all', ->
      t.row class: 'user', ->
        t.cell '{{firstName}}'
        t.cell '{{lastName}}'
        t.cell '{{email}}'
  t.foot ->
    nav class: 'pagination', ->
      ul ->
        a class: 'first', 'data-page': 'first', href: '#', 'First'
        a class: 'prev', 'data-page': 'prev', href: '#', 'Previous'
        a class: 'next', 'data-page': 'next', href: '#', 'Next'
        a class: 'last', 'data-page': 'last', href: '#', 'Last'

# controller
class App.UsersController extends Tower.Controller
  @on 'click table .pagination a', 'paginate'
  
  paginate: (event) ->
    link            = $(event.currentTarget)
    currentPage     = @currentPage ||= 1
    totalPages      = @totalPages || 1
    
    page  = switch link.attr('data-page')
      when 'first' then 1
      when 'prev' then Math.max(currentPage - 1, 1)
      when 'next' then Math.min(currentPage + 1, totalPages)
      else totalPages
    
    App.User.page(page).fetch (error, users) =>
      @set 'all', users
```

## Building a navigation bar

### Plain jQuery

``` coffeescript
# view
nav id: 'navigation', ->
  ul ->
    li class: 'active', ->
      a href: '/', 'Dashboard'
    li ->
      a href: '/users', 'Users'
    li ->
      a href: '/posts', 'Posts'

# controller
class App.ApplicationController extends Tower.Controller
  @on 'click #navigation a', 'navigate'

  navigate: (event) ->
    link = $(event.currentTarget)
    $('#navigation li').removeClass('active')
    link.find('li').addClass('active')
```

The problem with this is if you can navigate to the same place one of these navigation items takes you (perhaps a "back" or "cancel" button on a popup or form), then you have to somehow update the `class` for these navigation items, which are unrelated to those buttons from a view standpoint even though they end up performing the same action.

### Ember.js

``` coffeescript
# view
nav id: 'navigation', ->
  ul ->
    li '{{bindAttr class="App.applicationController.isActive"}}', ->
      a href: '/', 'Dashboard'
    li '{{bindAttr class="App.usersController.isActive"}}', ->
      a href: '/users', 'Users'
    li '{{bindAttr class="App.postsController.isActive"}}', ->
      a href: '/posts', 'Posts'
```

There are a bunch of ways you can handle this in Ember.js:

- `bindAttr` in your list item, binding to a state in a specific matching controller
- `bindAttr` in your list item, binding to a state in the `applicationController`, which sets variables such as `isUserControllerActive`, etc.
- you can somehow bind to the `App.stateManager`
- do it the jQuery way

## Building a form

### Plain jQuery

### Ember.js

## Collections

Ember gives you an easy way to tell it what to display when there are no items in the list.