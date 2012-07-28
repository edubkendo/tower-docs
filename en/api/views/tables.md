# Tables

``` coffeescript
tableFor 'users', (t) ->
  t.head ->
    t.row ->
      t.header 'name', width: 400, sort: true
      t.header 'createdAt', sort: true
  t.body ->
    for user in users
      t.row ->
        t.cell ->
          linkTo(user.name, adminUserPath(user))
        t.cell ->
          time user.createdAt
  t.foot ->
    t.row ->
      t.cell colspan: 2, ->
        render partial: 'shared/pagination', locals: {collection: @users}
```

``` html
<table class='data-table' data-for='users' data-url='/admin/users' id='users-table' role='grid' summary='Table for Users'>
  <thead>
    <tr role='row' scope='row'>
      <th abbr='name' aria-sort='none' class='sortable' id='users-header-1-0' role='columnheader' scope='col' width='400px'>
        <a href="/admin/users?sort=name+">Name</a>
      </th>
      <th abbr='createdAt' aria-sort='none' class='sortable' id='users-header-1-1' role='columnheader' scope='col'>
        <a href="/admin/users?sort=createdAt+">Created At</a>
      </th>
    </tr>
  </thead>
  <tbody>
    <tr class='odd' role='row' scope='row'>
      <td headers='users-header-1-0' id='users-cell-1-0' role='gridcell'>
        <a href="/admin/users/2288">Lance Pollard</a>
      </td>
      <td headers='users-header-1-1' id='users-cell-1-1' role='gridcell'>
        <time>5/29/2011 @ 03:44pm</time>
      </td>
    </tr>
    <tr class='even' role='row' scope='row'>
      <td headers='users-header-1-0' id='users-cell-2-0' role='gridcell'>
        <a href="/admin/users/2287">John Smith</a>
      </td>
      <td headers='users-header-1-1' id='users-cell-2-1' role='gridcell'>
        <time>5/29/2011 @ 03:40pm</time>
      </td>
    </tr>
  </tbody>
  <tfoot>
    <tr role='row' scope='row'>
      <td colspan='3' headers='users-header-1-0' id='users-cell-1-0' role='gridcell'>
        <nav class='paginator' role='toolbar'>
          <ul class='goto-pages'>
            <li class='goto-search'>
              <a href="#search" class="search-pages" title="Toggle Advanced Search">&#8981;</a>
            </li>
            <li class='goto-page'>
              <a href="/admin/users?page=1" aria-disabled="true" class="first-page disabled" data-page="1" rel="first" title="Go to the first page">&#8676;</a>
            </li>
            <li class='goto-page'>
              <a href="/admin/users?page=1" aria-disabled="true" class="prev-page disabled" data-page="1" rel="prev" title="Go to page 1">&#8672;</a>
            </li>
            <li aria-valuemax='109' aria-valuemin='1' aria-valuetext='1' class='goto-page current-page' role='spinbutton'>
              <span>Page</span>
              <input class='current-page-input' value='1'>
              <span>of</span>
              <span class='page-count'>109</span>
            </li>
            <li class='goto-page'>
              <a href="/admin/users?page=2" aria-disabled="false" class="next-page yes" data-page="2" rel="next" title="Go to page 2">&#8674;</a>
            </li>
            <li class='goto-page'>
              <a href="/admin/users?page=109" aria-disabled="false" class="last-page yes" data-page="109" rel="last" title="Go to the last page">&#8677;</a>
            </li>
          </ul>
          <output class='record-count'>
            <span>Viewing</span>
            <span class='current-record-range'>1 - 20</span>
            <span>of</span>
            <span class='total-record-count'>2178</span>
          </output>
        </nav>
      </td>
    </tr>
  </tfoot>
</table>
```

## Dynamic Admin Tables

You can build a table that works for any model very easily (todo, since you can't totally do this yet in Handlebars):

``` coffeescript
hWith 'App.User', ->
  tableFor '{{name}}', (t) ->
    t.head ->
      t.row ->
        hEach 'fields', ->
          t.header '{{name}}', sort: true
    t.body ->
      hEach 'all', ->
        t.row ->
          hEach 'fields', ->
            t.cell '{{get(name)}}'
    t.foot ->
```

## Tables

``` coffeescript
section id: 'users-page', class: 'page', ->
  header class: 'header', ->
    h2 'Users'
  div class: 'content', ->
    tableFor 'users', (t) ->
      t.head ->
        t.row ->
          t.header 'First Name'
          t.header 'Last Name'
          t.header 'Email'
      t.body ->
        for user in @users
          t.row class: 'user', 'data-id': user.get('id').toString(), ->
            t.cell class: 'first-name', -> user.get('firstName')
            t.cell class: 'last-name', -> user.get('lastName')
            t.cell class: 'email', -> user.get('email')
  footer class: 'footer', ->
```
