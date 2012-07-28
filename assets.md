
## Asset Uploading

There is some problem where it looks like the file may not be fully written to the filesystem locally, and when you upload it to s3 everything looks fine but when you visit the url such as:

```
http://cloud.example.com/javascripts/lib-47ea7d6d770095d68325d0a928874301.js
```

it says the file doesn't exist, even though you can see it if you FTP into the S3 server! It seems to be random, but it may depend on the filesize (> 500kb, which doesn't make sense), but it probably is because it's somehow not written properly to S3. Still figuring out...  The crazy thing is, it's happening when the files are in this order (in `config/assets.coffee`):

``` coffeescript
vendor: [
  '/vendor/javascripts/underscore'
  '/vendor/javascripts/underscore.string'
  '/vendor/javascripts/moment'
  '/vendor/javascripts/geolib'
  '/vendor/javascripts/validator'
  '/vendor/javascripts/accounting'
  '/vendor/javascripts/inflection'
  '/vendor/javascripts/coffeekup'
  '/vendor/javascripts/prettify'
  '/vendor/javascripts/async'
  '/vendor/javascripts/socket.io'
  '/vendor/javascripts/handlebars'
  '/vendor/javascripts/ember'
  '/vendor/javascripts/tower'
  '/vendor/twitter-bootstrap/js/bootstrap-twipsy'
  '/vendor/twitter-bootstrap/js/bootstrap-popover'
]
```

but when the last two are switched, it works fine???

``` coffeescript
vendor: [
  '/vendor/javascripts/underscore'
  '/vendor/javascripts/underscore.string'
  '/vendor/javascripts/moment'
  '/vendor/javascripts/geolib'
  '/vendor/javascripts/validator'
  '/vendor/javascripts/accounting'
  '/vendor/javascripts/inflection'
  '/vendor/javascripts/coffeekup'
  '/vendor/javascripts/prettify'
  '/vendor/javascripts/async'
  '/vendor/javascripts/socket.io'
  '/vendor/javascripts/handlebars'
  '/vendor/javascripts/ember'
  '/vendor/javascripts/tower'
  # switched these
  '/vendor/twitter-bootstrap/js/bootstrap-popover'
  '/vendor/twitter-bootstrap/js/bootstrap-twipsy'
]
```

Here is an example request

```
Request URL:http://cloud.example.com.s3.amazonaws.com/stylesheets/application-bae0e0f7bcec9cba84950ead5e5907c4.css
Request Method:GET
Status Code:206 Partial Content
Request Headersview source
Accept:text/css,*/*;q=0.1
Accept-Charset:ISO-8859-1,utf-8;q=0.7,*;q=0.3
Accept-Encoding:gzip,deflate,sdch
Accept-Language:en-US,en;q=0.8
Cache-Control:max-age=0
Connection:keep-alive
Host:cloud.example.com.s3.amazonaws.com
If-Range:"9be806c9b5a78f3ff7061176bace764c"
Range:bytes=1027-1027
Referer:http://rituwall-development.herokuapp.com/
User-Agent:Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_7) AppleWebKit/536.11 (KHTML, like Gecko) Chrome/20.0.1132.43 Safari/536.11
Response Headersview source
Accept-Ranges:bytes
Cache-Control:public
Content-Length:1
Content-Range:bytes 1027-1027/119790
Content-Type:text/css
Date:Thu, 28 Jun 2012 00:56:09 GMT
ETag:"9be806c9b5a78f3ff7061176bace764c"
Expires:Fri, 28 Jun 2013 00:39:02 GMT
Last-Modified:Thu, 28 Jun 2012 00:39:04 GMT
Server:AmazonS3
x-amz-id-2:SA8cjneb7VHRYk2Ly0Q1ky1I39E5QKIPGKS8sl1hXvfzLXxo1h1aNz1jrqLC6MiC
x-amz-request-id:3DE75DC923D7E01E
```

And... it gets solved by appending random characters to the path `.css?asdf`.