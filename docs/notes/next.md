
### More

```
Tower.Model.toParam = ->
  Tower.Support.String.underscore(Tower.Support.String.pluralize(@name)).replace("_", "-")
  
Tower.Model::toParam = ->
  @id.toString()
  
Tower.Route.find = (options) ->
  routes  = @all()
  for route in routes
    success = true
    for key, value of options
      console.log route
      success = route.controller[key] == value
      break unless success
    return route if success
  null
