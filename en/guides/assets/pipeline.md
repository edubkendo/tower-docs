# Pipeline

Tower has a built-in asset compilation and deployment pipeline.  The `config/assets.coffee` manifest defines how assets are bundled.

- Asset Manifest
- Watchfile

## Tasks

```
cake assets:bundle
cake assets:upload # cake assets:upload:s3
cake assets:stats
```

### Asset Compression

Bundles all the assets

### Upload Assets to S3

### Print Asset Sizes

## Asset Manifest

``` coffeescript
module.exports =
  javascripts:
    application: [
      '/app/models/user'
      '/app/models/post'
    ]
    bottom: [
      '/vendor/assets/javascripts/jmd/showdown'
      '/vendor/assets/javascripts/jmd/jquery.markedit'
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
      '/app/assets/stylesheets/reset'
      '/app/assets/stylesheets/typography'
    ]
    application: [
      '/app/assets/stylesheets/application'
    ]
```

## Notes

Node 0.6.0 has a stable zlib in its core now: http://nodejs.org/docs/v0.6.7/api/zlib.html#zlib.  The alternative was to use gzippo.