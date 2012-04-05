# Browser Testing

## Acceptance Testing

[Mocha](http://visionmedia.github.com/mocha/) can be used to "spec" an app including specs for acceptance testing.
See the Tower test code for examples on how to use it.

The "BDD" interface provides: describe(), it(), before(), after(), beforeEach(), and afterEach().
The "TDD" interface provides: suite(), test(), setup(), and teardown().

- [Javascript testing with Mocha](http://www.adomokos.com/2012/01/javascript-testing-with-mocha.html)

To setup Mocha for browser use all you have to do is include the script, stylesheet, tell Mocha which interface you wish to use, and then run the tests. A typical setup might look something like the following, where we call `mocha.setup('bdd')` to use the _BDD_ interface before loading the test scripts, running them onload with `mocha.run()`.

``` html
<html>
<head>
  <meta charset="utf-8">
  <title>Mocha Tests</title>
  <link rel="stylesheet" href="mocha.css" />
  <script src="jquery.js"></script>
  <script src="expect.js"></script>
  <script src="mocha.js"></script>
  <script>mocha.setup('bdd')</script>
  <script src="test.array.js"></script>
  <script src="test.object.js"></script>
  <script src="test.xhr.js"></script>
  <script>
    $(function(){
      mocha
        .globals(['foo', 'bar']) // acceptable globals
        .run()
    })
  </script>
</head>
<body>
  <div id="mocha"></div>
</body>
</html>
```

## Design.IO

Run watch tasks when a file changes, and inject the result into the browser.

- [Design IO on github](https://github.com/viatropos/design.io)