# Overview

`Tower.Model` provides a standard set of interfaces for usage in model classes.

`Tower.Model` also helps building custom ORMs for use outside of Tower.js.

`Tower.Model` provides the **same interface** on the client and the server.  When you're on the client, it knows how to store the data in memory or through ajax to the server (more below).  When you're on the server, it's saving it to MongoDB (by default), or CouchDB or Neo4j or wherever.  If the backend store isn't implemented, it's pretty easy for you to add.  See the `Tower.Store` section.

This means you can technically write one set of models and it will work in Node.js and the browser.  Super sweet.  In reality though, you'll want to add functionality specific to the client (jQuery stuff) and server (background jobs like emailing, etc.), but for simple apps you can get away with one set of models!
