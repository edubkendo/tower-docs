# Setting up the Development Environment

To move on from submitting bugs to helping resolve existing issues or contributing your own code to Tower, you must be able to run its test suite. In this section of the guide you'll learn how to set up the tests on your own computer.

## 1. Install Homebrew

First, install [Homebrew](http://mxcl.github.com/homebrew/) by following the [Homebrew installation instructions](https://github.com/mxcl/homebrew/wiki/installation) (or just paste this into the terminal)

```
/usr/bin/ruby -e "$(/usr/bin/curl -fksSL https://raw.github.com/mxcl/homebrew/master/Library/Contributions/install_homebrew.rb)"
```

## 2.2 Install XCode

XCode 4 is required for git to work.

- Visit the [XCode page in the Mac App store](http://itunes.apple.com/us/app/xcode/id497799835?ls=1&mt=12)
- Click the blue button "View in Mac App store"
- Click the dropdown that says "Free"

It might require you to upgrade your operating system, so either find an older version of XCode or take the time to upgrade.  It's better to get the latest version of XCode.

## 2.2 Install Git

If you don't have git already, it's easy to install

```
brew install git
```

## 2.3 Install Node and NPM

```
brew install node
curl http://npmjs.org/install.sh | sh
```

## 2.3 Install MongoDB

```
brew install mongodb
```

Then follow the instructions output in the terminal to start mongodb (`mongod start`).

## 2.4 Install Redis

```
brew install redis
```

Not using Redis yet.

## 2.5 Download Tower

Fork Tower and clone your fork

```
git clone git://github.com/<username>/tower.git
cd tower
```

## 2.6 Install node modules

The npm command uses the [[package-json]] file to determine and install dependencies similar to the Gemfile for Bundler in Rails. If you stand in the Tower root dir and run `npm install` all development dependencies should be installed globally.

```
npm install -g
```

If for some reason that doesn't work, you can install them manually...

```
$ npm install mocha redis mongodb underscore underscore.logger underscore.string pathfinder async 
$ npm install restler chai sinon moment coffeekup mime
```

## 2.7. Run the Test Suite

Now that you have everything installed and running, time to run the Tower test suite.

```
npm test
```

Tower uses [Mocha](http://visionmedia.github.com/mocha/) for writing tests.