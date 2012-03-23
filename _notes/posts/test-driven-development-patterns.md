# Build Testable Objects

If your system is at all complex, break out functionality into smaller objects that you can test independently.  This is why I broke down Tower "chainable queries" into a `Scope` and a `Criteria` object, rather than just having a `Scope` object.  And the reason why there's a distinction between the "model" and "data" (store/datastore) layers.

By doing this, I was able to quickly build out most of the functionality for query generation using just the `Criteria` object.  Then I knew I could get back a hash of conditions and options to use in finding records from a data store.

This makes the whole project more manageable and makes rapid development possible.  I found my mind spinning in circles trying to grasp the whole system at once otherwise.

However, note this: there's a tradeoff between testability and performance.  If every single thing was built as nested objects like the above two examples, you'd end up creating a ton of objects to do (often) pretty simple things, and this is bad from both a memory and performance standpoint.  In most cases it also increases the amount of code you have to write, which more than anything means the browser will have to load more code.  So, if something's easy to test without refactoring it into objects, just leave it that way.  It's less code for the browser to download, and will most likely use up less memory, which means a better user experience in the end.