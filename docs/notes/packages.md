# Tower.js Assets

You can divide up Tower.js into smaller chunks to take advantage of code reuse to decrease the amount of code the browser loads!  It's more work, but you end up with a smaller bundle.

## Making `Tower.Support.X` modules part of Underscore.js

Right now I've divided the "support" code into separate modules based on functionality:

- Tower.Support.String
- Tower.Support.RegExp
- Tower.Support.Array
- Tower.Support.Object
- Tower.Support.Date
- Tower.Support.Number

There are no name conflicts with any of those methods, and they don't conflict with any of underscore's existing methods (or any of the methods in any of the underscore extension libraries I've seen).  So, it makes sense to add them to underscore, since they're commonly used and it will convert methods like `Tower.Support.String.camelize` to `_.camelize`, cutting out extra characters and simplifying the API.

