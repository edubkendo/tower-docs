# Tower Views

Tower has built in support for every template framework.

- HTML5 Bootstrap
- Twitter Bootstrap

## Helper Methods

- HTML5 tags
- formFor
- tableFor
- partial
- render
- yields
- contentFor
- hasContentFor

# Components

- Forms
- Tables
- Menus and lists
- Breadcrumbs
- Definition lists
- Generic "widgets"

A lot of thought was put into figuring out the conventions behind most of the HTML components we use.  Where applicable, you can opt-into [ARIA-roles](http://www.w3.org/TR/wai-aria/roles) as well. The structures all have sensible defaults, but they can be globally configured no problem.

Tower also includes several "meta-level" helpers, such as:

- Internet explorer hacks to build things like vertically/horizontally centered images (where the width of the image is unknown), and to apply CSS sprites to rich buttons for IE6.  You need the structure `<div><span><span>[<input/>|<img/>]</div>` to do this.
- User agent helpers (to perform human-readable checks on the browser, operating system, etc.).
- HTML "head" helpers (meta tags, titles, keywords, links, etc.).
- Fragment caching helpers, like conditional caching.
- An extension to the building in `t()` I18n method to allow past/present/future and zero/one/many keys and several more options.
