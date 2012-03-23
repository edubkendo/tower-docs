## Testing ARGV

To test terminal commands, you can mock out `program.ARGV`:

``` coffeescript
program = require('commander')
program
  .version('0.0.1')
  .option('-f, --foo', 'add some foo')
  .option('-b, --bar', 'add some bar')

argv = ['node', 'test', '--foo', '--', '--bar', 'baz'] # program.ARGV mock

program.parse(argv)
```

## Testing STDIN

## Testing STDOUT
