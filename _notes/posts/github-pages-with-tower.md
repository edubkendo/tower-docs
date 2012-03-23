# GitHub Pages for Tower

Add top-level [Jekyll](https://github.com/mojombo/jekyll) `_config.yml` file pointing to public directory:

``` yaml
safe:        false
auto:        false
server:      false

source:      ./public
destination: ./_site

future:      true
lsi:         false
pygments:    true
markdown:    maruku
```

This will copy all of your files from `./public` to `./_site`, which GitHub will route to your project url:

> http://username.github.com/project-name
> http://username.github.com/project-name/about
> http://username.github.com/project-name/javascripts/application.js

That's clean :)