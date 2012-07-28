# Helpers

Most helpers in Tower are included in the underscore `_` namespace, because they are generic enough to be useable outside of Tower itself.  The rest are included in the `Tower` namespace.

## Tower Helpers

``` coffeescript
Tower.urlFor
Tower.get
Tower.post
Tower.put
Tower.action
Tower.constant
```

## Underscore Helpers

### String Helpers

#### `_.pluralize`

``` coffeescript
_.pluralize('business')   #=> 'businesses'
_.pluralize('businesses') #=> 'businesses'
_.pluralize('person')     #=> 'people'
_.pluralize('people')     #=> 'people'
```

#### `_.singularize`

``` coffeescript
_.singularize('business')   #=> 'business'
_.singularize('businesses') #=> 'business'
_.singularize('person')     #=> 'person'
_.singularize('people')     #=> 'person'
```

### Object Helpers

#### `_.isHash`

``` coffeescript
_.isHash({}) #=> true
_.isHash({key: 'value'}) #=> true
_.isHash(new App.User) #=> false
```

#### `_.isObject`

``` coffeescript
_.isObject({})              #=> true
_.isObject({key: 'value'})  #=> true
_.isObject(new App.User)    #=> true
```

### Date Helpers

``` coffeescript
_(number)[interval]()[timeframe]()
_(2).days().fromNow().toDate()
_(3).years().ago().toDate()
_('Dec 25, 2012').toDate()
```

### Validation Helpers