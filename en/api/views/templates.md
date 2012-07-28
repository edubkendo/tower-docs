# Templates

## CoffeeKup

## Automatic Template Refreshing in Browser

When you _save_ a template, you're either saving a template, partial, or layout.

- If you save a layout, it will reload the html page.
- If you save a template, it will go to the url for that template.  If you have the templates in view it will render without refreshing.  If history.pushState is available then the url will change as well.  This triggers the controller to run the render method again.
- If you save a partial, it will use jQuery to find/replace the partial in the cached version in the browser, and rerun the controller action if that partial was used in the last controller action.

## Examples

### Coffeekup + Mustache

``` coffeescript
handlebars 'each', 'posts', ->
  h2 '{{title}}'
  p '{{body}}'
```

``` html
{{#each posts}}
  <h2>{{title}}</h2>
  <p>{{body}}</p>
{{/posts}}
```