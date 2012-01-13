
### More

```
Tower.Support.String.parameterize = (string) ->
  Tower.Support.String.underscore(string).replace(/[^a-z0-9]+/g, "-").replace(/^-+|-+$/g, "-").replace(/^-+|-+$/g, '')

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

# use single quotes, otherwise they're escaped
Tower.Support.String.toQueryValue = (value, negate = "") ->
  if Tower.Support.Object.isArray(value)
    items = []
    for item in value
      result  = negate
      result += item
      items.push result
    result = items.join(",")
  else
    result    = negate
    result   += value.toString()
  
  result = result.replace(" ", "+").replace /[#%\"\|<>]/g, (_) -> encodeURIComponent(_)
  result

# toQuery likes: 10
# toQuery likes: ">=": 10
# toQuery likes: ">=": 10, "<=": 20
# toQuery tags: ["ruby", "javascript"]
# toQuery tags: "!=": ["java", ".net"]
#   #=> tags=-java,-ruby
# toQuery tags: "!=": ["java", ".net"], "==": ["ruby", "javascript"]
#   #=> tags=ruby,javascript,-java,-ruby
Tower.Support.String.toQuery = (object, schema = {}) ->
  result = []
  
  for key, value of object
    param   = "#{key}="
    type    = schema[key] || "string"
    negate  = if type == "string" then "-" else "^"
    
    if Tower.Support.Object.isHash(value)
      data          = {}
      data.min      = value[">="] if value.hasOwnProperty(">=")
      data.min      = value[">"]  if value.hasOwnProperty(">")
      data.max      = value["<="] if value.hasOwnProperty("<=")
      data.max      = value["<"]  if value.hasOwnProperty("<")
      data.match    = value["=~"] if value.hasOwnProperty("=~")
      data.notMatch = value["!~"] if value.hasOwnProperty("!~")
      data.eq       = value["=="] if value.hasOwnProperty("==")
      data.neq      = value["!="] if value.hasOwnProperty("!=")
      data.range    = data.hasOwnProperty("min") || data.hasOwnProperty("max")
      
      set = []
  
      if data.range && !(data.hasOwnProperty("eq") || data.hasOwnProperty("match"))
        range = ""
        
        if data.hasOwnProperty("min")
          range += Tower.Support.String.toQueryValue(data.min)
        else
          range += "n"
        
        range += ".."
        
        if data.hasOwnProperty("max")
          range += Tower.Support.String.toQueryValue(data.max)
        else
          range += "n"
        
        set.push range
      
      if data.hasOwnProperty("eq")
        set.push Tower.Support.String.toQueryValue(data.eq)
      if data.hasOwnProperty("match")
        set.push Tower.Support.String.toQueryValue(data.match)
      if data.hasOwnProperty("neq")
        set.push Tower.Support.String.toQueryValue(data.neq, negate)
      if data.hasOwnProperty("notMatch")
        set.push Tower.Support.String.toQueryValue(data.notMatch, negate)
      
      param += set.join(",")
    else
      param += Tower.Support.String.toQueryValue(value)
    
    result.push param
  
  result.sort().join("&")
  
Tower.Support.String.extractDomain = (host, tldLength = 1) ->
  return null unless @namedHost(host)
  parts = host.split('.')
  parts[0..parts.length - 1 - 1 + tldLength].join(".")

Tower.Support.String.extractSubdomains = (host, tldLength = 1) ->
  return [] unless @namedHost(host)
  parts = host.split('.')
  parts[0..-(tldLength+2)]
  
Tower.Support.String.extractSubdomain = (host, tldLength = 1) ->
  @extractSubdomains(host, tldLength).join('.')

Tower.Support.String.namedHost = (host) ->
  !!!(host == null || /\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/.exec(host))
  
Tower.Support.String.rewriteAuthentication = (options) ->
  if options.user && options.password
    "#{encodeURI(options.user)}:#{encodeURI(options.password)}@"
  else
    ""

Tower.Support.String.hostOrSubdomainAndDomain = (options) ->
  return options.host if options.subdomain == null && options.domain == null
  
  tldLength = options.tldLength || 1
  
  host = ""
  unless options.subdomain == false
    subdomain = options.subdomain || @extractSubdomain(options.host, tldLength)
    host += "#{subdomain}." if subdomain
    
  host += (options.domain || @extractDomain(options.host, tldLength))
  host

# urlFor controller: "posts", action: "index"
# urlFor @user
# urlFor User
# urlFor "admin", @user
# Tower._urlFor({onlyPath: true, params: {likes: {">=": -10, "<=": 20, "!=": [13, 15]}, tags: {"==": ["ruby", /javascript /i], "!=": ["java"]}}, trailingSlash: false}, {likes: "integer"})
# "?likes=-10..20,^13,^15&tags=ruby,/javascript+/i,-java"
Tower.Support.String.urlFor = (options) ->
  unless options.host || options.onlyPath
    throw new Error('Missing host to link to! Please provide the :host parameter, set defaultUrlOptions[:host], or set :onlyPath to true')

  result  = ""  
  params  = options.params || {}
  path    = (options.path || "").replace(/\/+/, "/")
  schema  = options.schema || {}
  
  delete options.path
  delete options.schema
  
  unless options.onlyPath
    port  = options.port
    delete options.port
    
    unless options.protocol == false
      result += options.protocol || "http"
      result += ":" unless result.match(Tower.Support.RegExp.regexpEscape(":|//"))
    
    result += "//" unless result.match("//")
    result += @rewriteAuthentication(options)
    result += @hostOrSubdomainAndDomain(options)
    
    result += ":#{port}" if port
    
  # params.reject! {|k,v| v.toParam.nil? }
  
  if options.trailingSlash
    result += path.replace /\/$/, "/"
  else
    result += path
    
  result += "?#{Tower.Support.String.toQuery(params, schema)}" unless Tower.Support.Object.isBlank(params)
  result += "##{Tower.Support.String.toQuery(options.anchor)}" if options.anchor
  result

# Tower.urlFor(RW.MongoUser.first(), {onlyPath: false, params: {likes: {">=": -10, "<=": 20, "!=": [13, 15]}, tags: {"==": ["ruby", /javascript#/i], "!=": ["java"]}}, trailingSlash: true, host: "rituwall.com", user: "lance", password: "pollard", anchor: {likes: 10}})
# "http://lance:pollard@rituwall.com/mongo-users/1?likes=-10..20,-13,-15&tags=ruby,/javascript%23/i,-java#likes=10"
Tower.urlFor = ->
  args = Tower.Support.Array.args(arguments)
  return null unless args[0]
  if args[0] instanceof Tower.Model || (typeof(args[0])).match(/(string|function)/)
    last = args[args.length - 1]
    if last instanceof Tower.Model || (typeof(last)).match(/(string|function)/)
      options = {}
    else
      options = args.pop()
      
  options ||= args.pop()
  
  result    = ""
  
  if options.controller && options.action
    route   = Tower.Route.find(name: options.controller.replace(/(Controller)?$/, "Controller"), action: options.action)
    if route
      result  = "/" + Tower.Support.String.parameterize(options.controller)
  else
    for item in args
      result += "/"
      if typeof(item) == "string"
        result += item
      else if item instanceof Tower.Model
        result += item.constructor.toParam() + "/" + item.toParam()
      else if typeof(item) == "function"
        result += item.toParam()
  
  result += switch options.action
    when "new" then "/new"
    when "edit" then "/edit"
    else
      ""
  
  options.path = result
  
  Tower.Support.String.urlFor(options)
  
Tower.get = ->
  url = Tower.urlFor(arguments...)

Tower.Route.draw ->
  

```


#@hasMany "streams", type: "RW.MongoStream"
#@hasMany "categories", type: "RW.MongoCategory", sourceType: "RW.MongoWall", sourceField: "categories", cache: true,
#@hasMany "categories", type: "RW.MongoCategory", sourceType: "RW.MongoWall", sourceField: "categories"
#  cacheIds: true, cacheCounter: true
#@hasMany "categories", type: "RW.MongoCategory", source: "walls.categories", cache: true