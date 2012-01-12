# Assets

## Compression

## Uploading

``` coffeescript
class Image extends Tower.Model
  @attachment "data", "10x10"
```

Then you can crop and upload the asset in the background:

``` coffeescript
Image.async("upload")
```

## Inject Raw Assets into the HTML Source

``` coffeescript
app     = Tower.Application.instance()
script  = (source) -> app.assets().find(source).read()
```

``` html
<!DOCTYPE html>
<html>
  <head>
    <script src="/javascripts/application.js" type="text/javascript"></script>
    <script type="text/javascript">
      #{script("application.js")}
    </script>
  </head>
  <body>
  </body>
</html>
```