# Helpers

``` coffeescript
html 5
  head
    stylesheets "base"
    stylesheets "vendor"
    stylesheets "application"
    stylesheets "theme"

    javascriptTag "http://ajax.aspnetcdn.com/ajax/modernizr/modernizr-1.7-development-only.js"
    javascriptTag "http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"
    javascriptTag "https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.16/jquery-ui.min.js"
    
    javascripts "vendor"
    javascripts "application"
    
    if Tower.env == "development"
      javascripts "development"
  body
    h1 "Hello World"
    
    javascripts "bottom"
```
