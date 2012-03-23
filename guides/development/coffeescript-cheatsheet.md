# CoffeeScript Cheat Sheet

### `=>` vs `->`

### `key in object`

``` coffeescript
return true if key of object
return true if object.hasOwnProperty(key)
```

### `{key1, key2}`

### `{@key1}`

``` coffeescript
@render "action", locals: {post: @post}
@render "action", locals: {@post}
```

