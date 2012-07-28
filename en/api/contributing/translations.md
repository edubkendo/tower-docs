# Contributing Translations

## Translating the Tower Guides

It's great to have people volunteer to translate the Tower Guides into their own language.

If you want to launch a translation, you should:

1. Fork the Tower.js wiki
2. Add folders for your own language (for example, ./pt-BR/guides for Brazilian Portuguese)
3. Copy the source files from `guides` to your own language folder, and translate them

## Current translation efforts

- [Japanese](https://towerjs.jp)

Here's how I am going to layout http://towerjs.org:

- /guides (/guides/models, /guides/application, etc.)
- /api (generated documentation)
- /community (links to github, google group, contributors, etc.)
- /roadmap
- /examples (list of projects with pictures)
- /screencasts
- /tests (client test suite)
- /contributors

The bulk of what you'd be translating would be under /guides (I might call this /docs, not 100% yet).  Currently, those files are in the wiki/docs folder when you clone the wiki. 

We said before we were going to go with the http://towerjs.jp domain for both the docs and the group.  My thinking then was, I didn't want to be a bottleneck for you getting your translations out there on the web.  But after further reflection, I think it would be easier and more manageable if everything _did_ go through the main site at http://towerjs.org.

The main reason is, you and other contributors who translate Tower into different languages, shouldn't have to purchase a domain and go through the hassle of managing an application on top of all your translation work... that just creates a barrier to writing translations.  If you _want_ to have your own domain and keep the app in sync with the towerjs.org repo, that's totally fine, but I think the default should only require that you just handle the markdown files you're translating.

Here's how we do that.

First, any translation should be accessible from http://towerjs.org/{locale}, so http://towerjs.org/ja/docs or http://towerjs.org/ja-JP/docs (not sure the exact locale for Japan).  I may want to make this a subdomain (i.e. http://ja-JP.towerjs.org/docs), but for now lets assume it will define a top-level path.

Second, to write the actual translations:

1. clone the wiki (https://github.com/viatropos/tower/wiki/_access).
2. copy/paste the [relevant] wiki pages into the locale (wiki/ja-JP/docs/models.md, etc.).
3. translate those pages.
4. submit a pull request.
5. I'll update the main site.

See https://github.com/viatropos/towerjs.org/blob/master/Cakefile#L102 for the markdown files currently being used on the main site.

In the end, this will work a lot like docrails where you just edit markdown files.