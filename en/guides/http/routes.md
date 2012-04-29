# Routes

Tower routes are modeled after Rails' routes.  Here's how you might write a few for a blogging app:

``` coffeescript
Tower.Route.draw ->
  @match "/login", to: "sessions#new", via: "get", as: "login"
  
  @resources "posts", ->
    @resources "comments"
  
  @namespace "admin", ->
    @resources "posts", ->
      @resources "comments", only: "index"
      
    @resources "users", ->
      @resources "comments", only: "index"
  
  @namespace "mobile", constraints: {subdomain: /^mobile$/}, ->
    @root "/", to: "mobile#index"
    
  @match "(/*path)", to: "application#index"
```

## Resourceful Routes

``` coffeescript
Tower.Route.draw ->
  # this...
  @resources "posts"
  
  # is equivalent to this...
  @match "/posts",          to: "posts#index",    via: "get"
  @match "/posts/new",      to: "posts#new",      via: "get"
  @match "/posts",          to: "posts#create",   via: "post"
  @match "/posts/:id",      to: "posts#show",     via: "get"
  @match "/posts/:id/edit", to: "posts#edit",     via: "get"
  @match "/posts/:id",      to: "posts#update",   via: "put"
  @match "/posts/:id",      to: "posts#destroy",  via: "delete"
```

## Nesting Routes

``` coffeescript

```

## (todo) Hardcore Routing Example

Here is a complete example straight from the Rails 3.2 test suite, soon to be in the Tower test suite.

``` coffeescript
Tower.Route.draw ->
  @defaultUrlOptions host: "towerjs.org"
  @resourcesPathNames correlationIndexes: "infoAboutCorrelationIndexes"

  @controller "sessions", ->
    @get  "login": "new"
    @post "login": "create"
    @destroy "logout": "destroy"
    
  @resource "session", ->
    @get "create"
    @post "reset"

    @resource "info"

    @member, ->
      @get "crush"

  @scope "bookmark", controller: "bookmarks", as: "bookmark", ->
    @get  "new", path: "build"
    @post "create", path: "create", as: ""
    @put  "update"
    @get  "remove", action: "destroy", as: "remove"

  @scope "pagemark", controller: "pagemarks", as: "pagemark", ->
    @get  "new", path: "build"
    @post "create", as: ""
    @put  "update"
    @get  "remove", action: "destroy", as: "remove"

  @match "account/logout": redirect("/logout"), as: "logoutRedirect"
  @match "account/login", to: redirect("/login")
  @match "secure", to: redirect("/secure/login")

  @match "mobile", to: redirect(subdomain: "mobile")
  @match "superNewDocumentation", to: redirect(host: "super-docs.com")

  @match "youtubeFavorites/"youtubeId"/"name"", to: redirect(YoutubeFavoritesRedirector)

  @constraints ((request) -> true), ->
    @match "account/overview"

  @match "/account/nested/overview"
  @match signIn: "sessions#new"
  
  @match "account/modulo/:name", to: @redirect("/%{name}s")
  @match "account/proc/:name", to: @redirect((params, request) -> "/#{params.name.pluralize}")
  @match "account/procReq": @redirect((params, request) "/#{req.method}")
  
  @match "account/google": @redirect("http://www.google.com/", status: 302)

  @match "openid/login", via: ["get", "post"], to: "openid#login"

  @controller "global", ->
    @get   "global/hideNotice"
    @match "global/export",      to: "export", as: "exportRequest"
    @match "/export/"id"/"file"",  to: "export", as: "exportDownload", constraints: { file: /.*/ }
    @match "global/"action""

  @match "/local/"action"", controller: "local"

  @match "/projects/status(."format")"
  @match "/404", to: lambda { |env| [404, {"Content-Type": "text/plain"}, ["NOT FOUND"]] }

  @constraints(ip: /192\.168\.1\.\d\d\d/), ->
    @get "admin": "queenbee#index"

  @constraints :"TestRoutingMapper":"IpRestrictor", ->
    @get "admin/accounts": "queenbee#accounts"

  @get "admin/passwords": "queenbee#passwords", constraints: :"TestRoutingMapper":"IpRestrictor"

  @scope "pt", as: "pt", ->
    @resources "projects", pathNames: { edit: "editar", new: "novo" }, path: "projetos", ->
      @post "preview", on: "new"
      @put "close", on: "member", path: "fechar"
      @get "open", on: "new", path: "abrir"
    @resource  "admin", pathNames: { new: "novo", activate: "ativar" }, path: "administrador", ->
      @post "preview", on: "new"
      @put "activate", on: "member"
    @resources "products", pathNames: { new: "novo" }, ->
      @new, ->
        @post "preview"

  @resources "projects", controller: "project", ->
    @resources "involvements", "attachments"
    @get "correlationIndexes", on: "collection"

    @resources "participants", ->
      @put "updateAll", on: "collection"

    @resources "companies", ->
      @resources "people"
      @resource  "avatar", controller: "avatar"

    @resources "images", as: "funnyImages", ->
      @post "revise", on: "member"

    @resource "manager", as: "superManager", ->
      @post "fire"

    @resources "people", ->
      @nested, ->
        @scope "/"accessToken"", ->
          @resource "avatar"

      @member, ->
        @get  "somePathWithName"
        @put  "accessibleProjects"
        @post "resend", "generateNewPassword"

    @resources "posts", ->
      @get  "archive", "toggleView", on: "collection"
      @post "preview", on: "member"

      @resource "subscription"

      @resources "comments", ->
        @post "preview", on: "collection"

  @resources "replies", ->
    @collection, ->
      @get "page/"page"": "replies#index", page: %r{\d+}
      @get ""page"": "replies#index", page: %r{\d+}

    @new, ->
      @post "preview"

    @member, ->
      @put "answer", to: "markAsAnswer"
      @delete "answer", to: "unmarkAsAnswer"

  @resources "posts", only: ["index", "show"], ->
    @namespace "admin", ->
      @root to: "index#index"
    @resources "comments", except: "destroy", ->
      @get "views": "comments#views", as: "views"

  @resource  "past", only: "destroy"
  @resource  "present", only: "update"
  @resource  "future", only: "create"
  @resources "relationships", only: ["create", "destroy"]
  @resources "friendships",   only: ["update"]

  @shallow, ->
    @namespace "api", ->
      @resources "teams", ->
        @resources "players"
        @resource "captain"

  @scope "/hello", ->
    @shallow, ->
      @resources "notes", ->
        @resources "trackbacks"

  @resources "threads", shallow: true, ->
    @resource "owner"
    @resources "messages", ->
      @resources "comments", ->
        @member, ->
          @post "preview"

  @resources "sheep", ->
    @get "_it", on: "member"

  @resources "clients", ->
    @namespace "google", ->
      @resource "account", ->
        @namespace "secret", ->
          @resource "info"

  @resources "customers", ->
    @get "recent", on: "collection"
    @get "profile", on: "member"
    @get "secret/profile": "customers#secret", on: "member"
    @post "preview": "customers#preview", as: "anotherPreview", on: "new"
    @resource "avatar", ->
      @get "thumbnail": "avatars#thumbnail", as: "thumbnail", on: "member"
    @resources "invoices", ->
      @get "outstanding": "invoices#outstanding", on: "collection"
      @get "overdue", to: "overdue", on: "collection"
      @get "print": "invoices#print", as: "print", on: "member"
      @post "preview": "invoices#preview", as: "preview", on: "new"
      @get "aged/"months"", on: "collection", action: "aged", as: "aged"
    @resources "notes", shallow: true, ->
      @get "preview": "notes#preview", as: "preview", on: "new"
      @get "print": "notes#print", as: "print", on: "member"
    @get "inactive", on: "collection"
    @post "deactivate", on: "member"
    @get "old", on: "collection", as: "stale"
    @get "export"

  @namespace "api", ->
    @resources "customers", ->
      @get "recent": "customers#recent", as: "recent", on: "collection"
      @get "profile": "customers#profile", as: "profile", on: "member"
      @post "preview": "customers#preview", as: "preview", on: "new"
    @scope(""version"", version: /.+/), ->
      @resources "users", id: /.+?/, format: /json|xml/

  @match "sprockets.js": :"TestRoutingMapper":"SprocketsApp"

  @match "people/"id"/update", to: "people#update", as: "updatePerson"
  @match "/projects/"projectId"/people/"id"/update", to: "people#update", as: "updateProjectPerson"

  # misc
  @match "articles/"year"/"month"/"day"/"title"", to: "articles#show", as: "article"

  # default params
  @match "inlinePages/("id")", to: "pages#show", id: "home"
  @match "defaultPages/("id")", to: "pages#show", defaults: { id: "home" }
  @defaults id: "home", ->
    @match "scopedPages/("id")", to: "pages#show"

  @namespace "account", ->
    @match "shorthand"
    @match "description", to: "description", as: "description"
    @match ""action"/callback", action: /twitter|github/, to: "callbacks", as: "callback"
    @resource "subscription", "credit", "creditCard"

    @root to: "account#index"

    @namespace "admin", ->
      @resource "subscription"

  @namespace "forum", ->
    @resources "products", path: "", ->
      @resources "questions"

  @namespace "users", path: "usuarios", ->
    @root to: "home#index"

  @controller "articles", ->
    @scope "/articles", as: "article", ->
      @scope path: "/"title"", title: /[a-z]+/, as: "withTitle", ->
        @match "/"id"", to: "withId", as: ""

  @scope ""accessToken"", constraints: { accessToken: /\w{5,5}/ }, ->
    @resources "rooms"

  @match "/info": "projects#info", as: "info"

  @namespace "admin", ->
    @scope "("locale")", locale: /en|pl/, ->
      @resources "descriptions"

  @scope "("locale")", locale: /en|pl/, ->
    @get "registrations/new"
    @resources "descriptions"
    @root to: "projects#index"

  @scope only: ["index", "show"], ->
    @resources "products", constraints: { id: /\d{4}/ }, ->
      @root to: "products#root"
      @get "favorite", on: "collection"
      @resources "images"
    @resource "account"

  @resource "dashboard", constraints: { ip: /192\.168\.1\.\d{1,3}/ }

  @resource "token", module: "api"
  @scope module: "api", ->
    @resources "errors", shallow: true, ->
      @resources "notices"

  @scope path: "api", ->
    @resource "me"
    @match "/": "mes#index"

  @get "(/"username")/followers": "followers#index"
  @get "/groups(/user/"username")": "groups#index"
  @get "(/user/"username")/photos": "photos#index"

  @scope "(groups)", ->
    @scope "(discussions)", ->
      @resources "messages"

  @match "whatever/"controller"(/"action"(/"id"))", id: /\d+/

  @resource "profile", ->
    @get "settings"

    @new, ->
      @post "preview"

  @resources "content"

  @namespace "transport", ->
    @resources "taxis"

  @namespace "medical", ->
    @resource "taxis"

  @scope constraints: { id: /\d+/ }, ->
    @get "/tickets", to: "tickets#index", as: "tickets"

  @scope constraints: { id: /\d{4}/ }, ->
    @resources "movies", ->
      @resources "reviews"
      @resource "trailer"

  @namespace "private", ->
    @root to: redirect("/private/index")
    @match "index", to: "private#index"

  @scope only: ["index", "show"], ->
    @namespace "only", ->
      @resources "clubs", ->
        @resources "players"
        @resource  "chairman"

  @scope except: ["new", "create", "edit", "update", "destroy"], ->
    @namespace "except", ->
      @resources "clubs", ->
        @resources "players"
        @resource  "chairman"

  @namespace "wiki", ->
    @resources "articles", id: /[^\/]+/, ->
      @resources "comments", only: ["create", "new"]

  @resources "wikiPages", path: "pages"
  @resource "wikiAccount", path: "myAccount"

  @scope only: "show", ->
    @namespace "only", ->
      @resources "sectors", only: "index", ->
        @resources "companies", ->
          @scope only: "index", ->
            @resources "divisions"
          @scope except: ["show", "update", "destroy"], ->
            @resources "departments"
        @resource  "leader"
        @resources "managers", except: ["show", "update", "destroy"]

  @scope except: "index", ->
    @namespace "except", ->
      @resources "sectors", except: ["show", "update", "destroy"], ->
        @resources "companies", ->
          @scope except: ["show", "update", "destroy"], ->
            @resources "divisions"
          @scope only: "index", ->
            @resources "departments"
        @resource  "leader"
        @resources "managers", only: "index"

  @resources "sections", id: /.+/, ->
    @get "preview", on: "member"

  @scope as: "routes", ->
    @get "/c/"id"", as: "collision", to: "collision#show"
    @get "/collision", to: "collision#show"
    @get "/noCollision", to: "collision#show", as: nil

    @get "/fc/"id"", as: "forcedCollision", to: "forcedCollision#show"
    @get "/forcedCollision", as: "forcedCollision", to: "forcedCollision#show"

  @match "/purchases/"token"/"filename"",
    to: "purchases#fetch",
    token: /[["alnum":]]{10}/,
    filename: /(.+)/,
    as: "purchase"

  @resources "lists", id: /([A-Za-z0-9]{25})|default/, ->
    @resources "todos", id: /\d+/

  @scope "/countries/"country"", constraints: lambda { |params, req| params["country"].in?(["all", "France"]) }, ->
    @match "/",       to: "countries#index"
    @match "/cities", to: "countries#cities"

  @match "/countries/"country"/(*other)", to: redirect{ |params, req| params["other"] ? "/countries/all/#{params["other"]}" : "/countries/all" }

  @match "/"locale"/*file."format"", to: "files#show", file: /path\/to\/existing\/file/

  @scope "/italians", ->
    @match "/writers", to: "italians#writers", constraints: :"TestRoutingMapper":"IpRestrictor"
    @match "/sculptors", to: "italians#sculptors"
    @match "/painters/"painter"", to: "italians#painters", constraints: {painter: /michelangelo/}
```