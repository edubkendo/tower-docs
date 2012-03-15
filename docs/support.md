# Extensions

## Callbacks

### Edge Case

```
success: ->
	initializer = (done) -> done()
  @runCallbacks "initialize", initializer

failure: ->
	# the method won't have arguments.length, because coffee-script wraps it.
	initializer = (done) => done()
  @runCallbacks "initialize", initializer
```