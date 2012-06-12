# HTTP Headers

Here is a [complete list of HTTP headers](http://en.wikipedia.org/wiki/List_of_HTTP_header_fields).  The focus of this section is on the most common ones and how to use them in Tower.

## Request Headers

Example request headers to http://towerjs.org:

```
Accept:     application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_7; en-us) AppleWebKit/533.21.1 (KHTML, like Gecko) Version/5.0.5 Safari/533.21.1
```

### `Accept`

### `Authorization` Header

### `Cache-Control`

### `Cookie`

### `Content-Length`

### `If-None-Match` Header

Used to check an `ETag`.

### `User-Agent`

### `X-Requested-With`

## Response Headers

Example response headers from http://towerjs.org

```
Age:                0
Connection:         close
Content-Encoding:   gzip
Content-Type:       text/html
Date:               Sat, 31 Mar 2012 20:58:56 GMT
Server:             nginx
Set-Cookie:         connect.sid=PUkUFKR8xSKYRLTlXSFKIpWL.XgLU%2BftoQsQzbWcjMc7Im1eiUHSiu7EfZOCbm9v0e9Z; domain=.undefined; path=/; expires=Sun, 01 Apr 2012 00:58:56 GMT; httpOnly
Transfer-Encoding:  Identity
Via:                1.1 varnish
X-Varnish:          2212951983
```

### `Age`

### `Cache-Control`

### `Connection`

### `Content-Encoding`

### `Content-Length`

### `Content-Type`

### `Date`

### `ETag` Header

### `Location`

### `Server` Header

### `Set-Cookie` Header

### `Via`

### `X-Powered-By`

Not a good idea to use this because it tells hackers too much about your app - now if there's a security hole in the framework, they know they can take advantage of this on your app.

### `X-XSS-Protection`