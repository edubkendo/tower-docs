# Todo

## Server Side

### Asset Workflow

- css sprites
- upload assets to amazon
- asset manifest
- better asset watcher
- asset server
- asset digest in name
- asset helpers

### Query Parsing

- params parser
- query parser
  - convert query into named scopes automatically (deli)
  
### Routes

- route regular expressions

### Lookups

- view lookups
- partial lookups

### Auto Reload

- development environment reload

### Views

- view responders
- view layouts

### Models

- finders
- validations
- callbacks
- serialization

### Stores

- mongo

### Presenters

- json api with presenters

### Controllers

- resourceful controller
- resourceful routes

### Settings

- internationalization

### Generators

- application generator
- model/view/controller generator

### Support

- logging with date, grouping, and ansii

## Client Side

- client version of library is just a smaller set of includes from the same src

### Routes

- html5 history pushstate

### Binding

It's easy to do binding from a model to a view, because we're creating the models and can dispatch events.  Without events, you have to run a timer.

Manual form:

``` coffeescript
post = new Post(title: "First Post")

Metro.bind $("#title").get(0), "innerHTML", post, "title"
Metro.bind $("title").get(0), "innerHTML", post, "title"
```
