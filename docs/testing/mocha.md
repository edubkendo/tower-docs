# Testing with Mocha

This command will watch the `test` directory, and anytime you save a file it will execute the tests.

```
mocha $(find test -name "*Test.coffee") -r coffee-script $@ -w
```