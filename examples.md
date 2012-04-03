# Examples

No examples yet really.  Coming soon.

## Todos

```
tower new todo --single-page
tower page todo
```

``` coffeescript
doctype 5
html ->
  head ->
    stylus """
    
    html, body
      margin: 0
      
    #todos
    """
    
    # http://addyosmani.github.com/todomvc
    script src: "https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"
    script src: "http://towerjs.org/javascripts/underscore.js"
    script src: "http://towerjs.org/javascripts/coffeekup.js"
    script src: "http://towerjs.org/javascripts/tower.js"
  
  body ->
    coffeescript ->
      class window.App extends Tower.Application
      
      class App.Todo extends Tower.Model
        @field "id", type: "Id"
        @field "name"
        @field "done", type: "Boolean"
  
        @scope "active", @where(done: false)
        @scope "done", @where(done: true)
      
      class App.TodosController extends Tower.Controller
        @on "submit form", "create"
        @on "change", "toggle"
        @on "click .destroy", "destroy"
        
        index: ->
          App.Todo.where(@criteria()).all (error, todos) =>
            @render "index"
        
        toggle: ->
          @todo.set "done", !@todo.get("done")
          @todo.save()
      
      App.views    
        "todos/_form": ->
        "todos/_item": ->
          li class: "todo", ->
            input type: "checkbox"
            span todo.get("name")
            a class: "destroy"
        "todos/index": ->
        "todos/new": ->
        "todos/edit": ->
      
      App.routes ->
        @resources "todos", pathName: ""
    
      App.run()
```

## GeekList / CoderWall / WorkingWithRails

You can chat with other node.js hackers too, and send code samples back and forth

```
tower new node-hacker
cd node-hacker
npm install
tower generate scaffold user firstName lastName email website twitter github
tower generate scaffold company website twitter email description:text founded:date
node server
```

## Cached Commons

```
tower new cached-commons --namespace CC
```

## Inspiration

- site where you can submit awesome sites

## Events (Attend)

- site like eventbrite

## Goal Tracker

- start timer when you start doing an event (watching movie), then every note you make can be tied to one of them.  This way you can easily mark "oh, at 38:57 in this movie there's a demonstration of leadership we need to cite in our book", etc.

## On top of Rails

## Sites in the Wild