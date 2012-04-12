# Deploying to Heroku

In the simple case, just deploy straight to production.  For "real" or live apps, a staging environment is important.  It mimics your production environment.  Push there first to make sure the latest code doesn't break anything.  Modify code if things do break, try again.  Then push to production.  Also, have a live "development" environment, where you can push your daily hacks even before staging to see how things are going. For demoing the app, have a dedicated "demo" deployment that's as close to possible to staging but isn't volatile.

### Setup (for Heroku)

First, [create apps on the Cedar stack](https://devcenter.heroku.com/articles/nodejs):

```
heroku create <%= app.name %> --stack cedar # production
heroku create <%= app.name %>-development --stack cedar
heroku create <%= app.name %>-staging --stack cedar
heroku create <%= app.name %>-demo --stack cedar
```

Then link to them:

```
git remote add production git@heroku.com:<%= app.name %>.git
git remote add development git@heroku.com:<%= app.name %>-development.git
git remote add staging git@heroku.com:<%= app.name %>-staging.git
git remote add demo git@heroku.com:<%= app.name %>-demo.git
```

### Create Branches

Develop using the same branching structure.  First, create the branches:

```
git branch development
git branch staging
git branch demo
```

Then checkout a branch and develop:

```
git checkout development
```

Change some code and commit the changes:

```
git add . ; git commit -a -m 'added code to dev branch'
```

### Pushing to Heroku

Push to Heroku using the robustness of `git push`:

```
git push <remote> <local-branch>:master
```

Where `remote` is the name given to app (`development` for `<%= app.name %>-development`), and `local-branch` is the branch you're working on (`development`).

```
git push development development:master
```

### Merging branches

To merge committed development changes to the other three branches and push all of the code to the respective remotes (I know it sounds like a lot, but it's definitely worth it), do this:

```
git checkout staging
git merge development
git push staging staging:master
# if no errors, nice! push to production
git checkout master
git merge staging
git push production master
# for the demo site
git checkout demo
git merge master
git push demo demo:master
```

### Logging

```
heroku logs --app <%= app.name %>-development -n 500 --tail
```
