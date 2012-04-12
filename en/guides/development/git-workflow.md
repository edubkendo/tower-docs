# Git Workflow

## Mac Terminal Workflow

- Each project gets its own terminal "window"
- Each project should have at least these 5 tabs for optimal flow:
  1. Tab for the local server, if it needs a server (`node server.js`)
  2. Tab to manage git commits, so the server can be running and you can still commit.
  3. Production log, if there is a production version
  4. For installing plugins/modules/gems, so you can be waiting for an installation to complete while still developing on your local server and pushing to git.
  5. Tab to git commit and push your project wiki, so it stays up to date.  Otherwise I've found you end up rarely syncing it to GitHub.

## Git Workflow

### Do all of your work on a `development` branch.

```
git branch development
git checkout development
# make changes
git add . ; git commit -a -m 'developed a new feature'
git push origin development
```

### Merge with other people's `development` branch into yours

```
# link to somebody else's fork, call it "upstream" or "username-upstream" or whatever
git remote add upstream git://github.com/username/project-name.git
git fetch upstream
# when you want to pull their changes into your current branch
git merge upstream/development
```

### Merge `development` to `master`

```
git branch # "development"
git add . ; git commit -a -m 'finished feature in development branch'
git checkout master
git merge development
git push origin master
```

### If you want to hack, create _another_ branch

You can have as many branches as you want.

```
git checkout development
git branch hacks # create "hacks" branch
git branch node5 # create "node7" branch, where you're upgrading code to work on node version 5.
```

### Use `remote` to push code to separate domains

Everybody calls GitHub their `origin`, so you do map the remote address to `origin` like this:

```
git remote add origin git://github.com/username/project-name.git
```

If you want to sync to somebody else's fork, you add another named remote:

```
git remote add lance git://github.com/viatropos/project-name.git
```

If you want to push your code to Heroku, you can add a heroku remote:

```
# heroku gives you this git address
git remote add heroku git@heroku.com:project-name.git
```

Ideally though, you have 3 branches of your project on heroku, and link remotes like this:

```
git remote add development git@heroku.com:project-name-development.git
git remote add staging git@heroku.com:project-name-staging.git
git remote add production git@heroku.com:project-name-production.git
pwd
# ~/documents/code/project-name
git branch
# development
git push development development:master
# pushes local "development" branch to remote "development" link's "master" branch
```

**That last line is the most important part of git**.  To push a branch to a remote master, do this:

```
git push <my-branch> <the-remote-name-i-gave-my-branch>:master
```

### Other helpful git commands

```
# check current branch you're on
git branch
# list all remote branches you're connected to
git remote -a
```

## Notes

The --no-ff flag causes the merge to always create a new commit object, even if the merge could be performed with a fast-forward. This avoids losing information about the historical existence of a feature branch and groups together all commits that together added the feature.

## Resources

- http://reinh.com/blog/2009/03/02/a-git-workflow-for-agile-teams.html
- http://nvie.com/posts/a-successful-git-branching-model/
- http://stackoverflow.com/questions/2850369/why-does-git-use-fast-forward-merging-by-default
- http://www.slideshare.net/can3p/uber-git-workflow-6813993

- npm install git://github.com/viatropos/inflection.git