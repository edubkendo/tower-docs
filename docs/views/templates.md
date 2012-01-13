# Templates

## Automatic Template Refreshing in Browser

## Examples

### Coffeekup + Mustache

``` coffeescript
mustacheEach "posts", ->
  h2 "{{title}}"
  p "{{body}}"
```

``` html
{{posts}}
  <h2>{{title}}</h2>
  <p>{{body}}</p>
{{/posts}}
```