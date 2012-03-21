# How to contribute to Tower development

This guide is for developing Tower in a Mac OS X environment.

## 1. Reporting an Issue

### 1.1 Bugs

### 1.2 Features

### 1.3 Questions

## 2. Setting up the Development Environment

To move on from submitting bugs to helping resolve existing issues or contributing your own code to Tower, you must be able to run its test suite. In this section of the guide you'll learn how to set up the tests on your own computer.

### 2.1 Install Homebrew

First, install [Homebrew](http://mxcl.github.com/homebrew/) by following the [Homebrew installation instructions](https://github.com/mxcl/homebrew/wiki/installation) (or just paste this into the terminal)

```
/usr/bin/ruby -e "$(/usr/bin/curl -fksSL https://raw.github.com/mxcl/homebrew/master/Library/Contributions/install_homebrew.rb)"
```

### 2.2 Install XCode

XCode 4 is required for git to work.

- Visit the [XCode page in the Mac App store](http://itunes.apple.com/us/app/xcode/id497799835?ls=1&mt=12)
- Click the blue button "View in Mac App store"
- Click the dropdown that says "Free"

It might require you to upgrade your operating system, so either find an older version of XCode or take the time to upgrade.  It's better to get the latest version of XCode.

### 2.2 Install Git

If you don't have git already, it's easy to install

```
brew install git
```

### 2.3 Install Node and NPM

```
brew install node
curl http://npmjs.org/install.sh | sh
```

### 2.3 Install MongoDB

```
brew install mongodb
```

### 2.4 Install Redis

```
brew install redis
```

### 2.5 Download Tower

```
git clone git://github.com/viatropos/tower.git
cd tower
```

### 2.6. Run the Test Suite

Now that you have everything installed and running, time to run the Tower test suite.

```
npm test
```

## 3. Contributing to the Tower Codebase

### 3.1 Create a dedicated branch

```
git branch development
git checkout development
```

It doesn't really matter what name you use, because this branch will only exist on your local computer and your personal repository on GitHub. It won't be part of the Tower git repository.

### 3.2 Compile the CoffeeScript Files for Tower

You need design.io running (to automatically compile coffee-script files, see the [design.io readme](https://github.com/viatropos/design.io) for info:

```
design.io watch
```

### 3.3 Write Your Code

### 3.4 Follow the Coding Conventions

Tower follows a simple set of coding style conventions.

- Two spaces, no tabs.
- No trailing whitespace. Blank lines should not have any space.
- Prefer &&/|| over and/or.
- `a = b` and not `a=b`.
- Follow the conventions you see used in the source already.

### 3.5 Commit Your Changes

When you're happy with the code on your computer, you need to commit the changes to git:

```
git commit -a -m "Here is a commit message on what I changed in this commit"
```

Please squash your commits into a single commit when appropriate. This simplifies future cherry picks, and also keeps the git log clean.

### 3.6 Fork Tower

### 3.7 Issue a Pull Request

### 3.8 Get Some Feedback

Now you need to get other people to look at your patch, just as you've looked at other people's patches. You can use the `#towerjs` channel on IRC freenode for this. You might also try just talking to Tower developers that you know.

## 4. Helping to Resolve Existing Issues

### 4.1 Verify Bug Reports

### 4.2 Testing Patches

## 5. Contributing to the Tower Documentation

Tower has two main sets of documentation: The guides help you to learn Tower, and the actual code API for reference.

You can help improve the Tower guides by making them more coherent, adding missing information, correcting factual errors, fixing typos, bringing it up to date with the latest edge Tower.

### 5.1 Translating the Tower Guides

It's great to have people volunteer to translate the Tower Guides into their own language.

If you want to launch a translation, you should:

1. Fork the Tower.js wiki
2. Add folders for your own language (for example, ./pt-BR/guides for Brazilian Portuguese)
3. Copy the source files from `guides` to your own language folder, and translate them

Current translation efforts:

- [Japanese](https://towerjs.jp)

## 6. Tower Contributors

All contributions, either via master or the wiki, get credit in [Tower Contributors](http://towerjs.org/contributors).

## Feedback

You're encouraged to help improve the quality of this guide.

If you see any typos or factual errors you are confident to patch, please clone the wiki and push the change yourself. That branch of Tower has public write access. Commits are still reviewed, but that happens after you've submitted your contribution. the wiki is cross-merged with master periodically.

You may also find incomplete content, or stuff that is not up to date. Please do add any missing documentation for master.

If for whatever reason you spot something to fix but cannot patch it yourself, please open an issue.

And last but not least, any kind of discussion regarding Tower documentation is very welcome on the [Tower Google Group](https://groups.google.com/group/towerjs).