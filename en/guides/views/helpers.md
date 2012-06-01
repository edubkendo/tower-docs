# View Helpers

## Global Helpers

In your `.coffee` templates you have access to a few global variables:

``` coffeescript
Tower
_     # underscore library
App   # your namespace
```

Tower has also defined a bunch of helpers, found in Tower's source in `./src/tower/view/helpers/`.

## Handlebars (Ember) Helpers

### `hEach`

``` coffeescript
hEach 'App.postsController.all', ->
  li '{{title}}'
```

## Asset Helpers

### `javascripts`

### `stylesheets`

## Component Helpers

### `formFor`

### `tableFor`

## Meta Helpers

### `appleMetaTags`

### `appleViewportMetaTag`

### `openGraphMetaTags`

## Custom Helpers

You also have access to any helpers you've included in `Tower.View`:

``` coffeescript
Tower.View.helper(App.ApplicationHelper)
```