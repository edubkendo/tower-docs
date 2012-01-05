## Resources

- https://github.com/nodejitsu/mock-request
- https://github.com/pgte/nock
- Catching HTTP exceptions: http://stackoverflow.com/questions/4328540/how-to-catch-http-client-request-exceptions-in-node-js
- https://github.com/cjohansen/sinon.js
- http://howto.no.de/http-mock-testing
- https://github.com/visionmedia/should.js

## Notes

LearnBoost seems to create a new server for every test! (https://github.com/LearnBoost/engine.io/blob/master/test/engine.io.js)

``` coffeescript
it "should attach engine to an http server", (done) ->
  server = http.createServer()
  engine = eio.attach(server)
  server.listen 4000, ->
    request.get "http://localhost:4000/engine.io", (err, res) ->
      expect(res.status).to.be 500
      server.once "close", done
      server.close()
```
