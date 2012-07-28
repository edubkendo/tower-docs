# Contributing to the Tower Codebase

Tower's `master` branch is always a reflection of what you'll get with `npm install`.  Tower's `development` branch is the latest stuff.  So when a pull request is merged, it's first going to be merged to development and it may be a while before it's pushed to master.  Issues will be closed when code is pushed to master.

First setup your Tower development [[environment]].

## Create a dedicated branch

```
git branch development
git checkout development
```

It doesn't really matter what name you use, because this branch will only exist on your local computer and your personal repository on GitHub. It won't be part of the Tower git repository.

This is also optional, but it's good practice. You can also use feature branches on your main development branch.

## Compile the CoffeeScript Files for Tower

You need design.io running (to automatically compile coffee-script files, see the [design.io readme](https://github.com/viatropos/design.io) for info:

```
design.io watch
```

## Write Your Code

The code should be written Test Driven. Use mocha to execute the Tower test suite.
To run the entire test suite from the console, simply execute:

```
npm test
```

That references the `test` key in [package.json](https://github.com/viatropos/tower/blob/e0e3348a1d36c35b8b088434185fb3b3529cc698/package.json#L82), which looks like this:

```
mocha $(find test -name "*Test.coffee")
```

You can customize this expression to run a subset of tests if you're developing something and don't want the clutter.

Example: run all "article" related tests

`mocha $(find test -name "article*Test.coffee")`

See [[Browser testing]] for more info.

## Follow the Coding Conventions

Tower follows a simple set of coding style conventions.

- Two spaces, no tabs.
- No trailing whitespace. Blank lines should not have any space.
- Prefer &&/|| over and/or.
- `a = b` and not `a=b`.
- Follow the conventions you see used in the source already.  Check the [style guide](https://github.com/viatropos/tower/wiki/style) for a few notes as well.

## Commit Your Changes

When you're happy with the code on your computer, you need to commit the changes to git:

```
git commit -a -m "Here is a commit message on what I changed in this commit"
```

Please [squash your commits into a single commit](http://ariejan.net/2011/07/05/git-squash-your-latests-commits-into-one) when appropriate. This simplifies future cherry picks, and also keeps the git log clean.

Before you do the final push, synchronize with upstream from @viatropos/master

```
git remote add upstream git@github.com:viatropos/tower.git
git fetch upstream
git merge upstream/master
```

## Issue a Pull Request

Push your code to your repository

`git push`

and [issue a pull request]((http://help.github.com/send-pull-requests/):

## Get Some Feedback

Now you need to get other people to look at your patch, just as you've looked at other people's patches. You can use the `#towerjs` channel on IRC freenode for this. You might also try just talking to Tower developers that you know.