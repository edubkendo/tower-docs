# NPM and `package.json`

The `package.json` file is standard to all Node.js modules using [NPM](http://npmjs.org/) (which implements the [CommonJS package format specification](http://wiki.commonjs.org/wiki/Packages/1.1)).

Without going into too much detail, here's what you need to know about each.

## `package.json`

The `package.json` file is a JSON description of your project.  This is the default `package.json` for a generated Tower.js app:

``` json
{
  "name":                 "my-app",
  "version":              "0.0.1",
  "description":          "Some one-liner description of your project.",
  "homepage":             "http://github.com/username/my-app",
  "main":                 "./server.js",
  "author":               "Your Name <your@email.com>",
  "keywords": [
    "node"
  ],
  "maintainers": [{
    "name":               "Your Name",
    "email":              "your@email.com"
  }],
  "contributors": [
  
  ],
  "licenses": [
    {
      "type":             "MIT",
      "url":              "http://mths.be/mit"
    }
  ],
  "bugs": {
    "url":                "http://github.com/username/my-app/issues"
  },
  "repository": {
    "type":               "git",
    "url":                "http://github.com/username/my-app.git"
  },
  "engines": {
    "node":               ">= 0.4.0"
  },
  "dependencies": {
    "tower":              ">= 0.3.0"
  },
  "devDependencies": {
    "coffee-script":      ">= 1.1.3",
    "stylus":             ">= 0.17.0",
    "uglify-js":          ">= 1.1.1",
    "design.io":          ">= 0.1.0"
  }
}
```

For all node modules that you'll need in both development and production environments, put them into `dependencies`.  Anything that you just need for development (like `uglify-js` for javascript compression), put that into `devDependencies`.

To install just production dependencies, run this command from your project root:

```
npm install --production
```

You can also do this by setting `NODE_ENV` to `production`.

To install both `dependencies` and `devDependencies`, run this command:

```
npm install
```

**Note**: When you push your app to Heroku, it's compiled to a "slug".  This makes it easy to clone and scale your app.  The ideal is to minimize the size of that slug so it's faster to clone.  The two biggest ways to do this are 1) minimize the number of images/pdfs/assets in your project (put them on S3 or something), and 2) minimize the number of modules you use in production.  So if you only need gzipping to compile your assets for production, put that into your `devDependencies`.

## NPM

Most of you are probably familiar with NPM, but here's just a quick list of helpful commands to streamline your development workflow.

More on NPM here: http://npmjs.org/doc.

### `npm install`

The first thing to do when you create a Tower project (or you `git clone` any node module from GitHub) is to `cd` into the project root and install the dependencies:

```
npm install
```

You can install a published npm module like this:

```
npm install coffee-script jade stylus
```

You can also install local modules:

```
npm install /Users/username/git/node/my-module
```

But when you're developing a module locally, it's a pain to constantly have to remove and reinstall it into the app that's using it.  That's where `npm link` comes in.

### `npm link`

The `npm link` command creates a symlink to a local node module that links it to the global npm module directory on your hard drive.  First step is to link `my-module` to the global directory:

```
$ cd /Users/username/git/node/my-module
$ npm link
/usr/local/lib/node_modules/my-module -> /Users/username/git/node/my-module
```

Then in any local project that's using it, run:

```
$ npm link my-module
./node_modules/my-module -> /usr/local/lib/node_modules/my-module -> /Users/username/git/node/my-module
```

I love `npm link`, it makes development so much easier.

### `npm publish`

To publish a module to the npm index, run:

```
npm publish
```

### NPM Scripts

Sometimes you want to run some code before/after your module is installed. Do this by defining npm `scripts` in your `package.json` (http://npmjs.org/doc/scripts.html).

Here's a `package.json` that installs a RubyGem after the node module is installed:

``` json
{
  ...
  "scripts": {
    "install": "gem install nokogiri"
  }
}
```
