# The Server

## Auto-reloading Changed Files

Internally Tower.js knows when a file was changed.  So when you refresh http://localhost:3000, it passes through the `Tower.Middleware.Dependencies` which re-requires any file that has changed.  This makes development uber fast, and prevents you from having to restart the server whenever a file changes (i.e. [nodemon](https://github.com/remy/nodemon)).  I mean, you can use nodemon if you want, it's a great project.  But you don't need to.