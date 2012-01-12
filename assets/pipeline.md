# Pipeline

Tower has a built-in asset compilation and deployment pipeline.  The `config/assets.coffee` manifest defines how assets are bundled.

- Asset Manifest
- Watchfile

## Asset Manifest

``` coffeescript
Tower.assets =
  javascripts:
    application: [
      '/app/models/user'
      '/app/models/post'
    ]
    bottom: [
      "/vendor/assets/javascripts/jmd/showdown"
      "/vendor/assets/javascripts/jmd/jquery.markedit"
    ]
    vendor: [
      '/vendor/assets/javascripts/tower'
      '/vendor/assets/javascripts/underscore'
    ]
    development: [
      '/vendor/assets/javascripts/jasmine'
      '/vendor/assets/javascripts/faker'
      '/vendor/assets/javascripts/coffeekup'
    ]
  
  stylesheets:
    base: [
      "/app/assets/stylesheets/reset"
      "/app/assets/stylesheets/typography"
    ]
    application: [
      "/app/assets/stylesheets/application"
    ]
    
try
  Tower.assetManifest = JSON.parse(require('fs').readFileSync('public/assets/manifest.json', 'utf-8'))
catch error
  Tower.assetManifest = {}
```

## Tasks

```
cake assets:bundle
cake assets:upload
```
