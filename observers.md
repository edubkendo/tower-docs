# Metro Observers

``` coffeescript
class ImagesPresenter
  afterShow: ->
    view = $(@body)
    view.appendTo("body").popup()
    Metro.bind $(".caption", view).get(0), "innerHTML", @image, "title"
```
