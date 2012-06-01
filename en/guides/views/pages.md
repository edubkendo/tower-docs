# General Architecture for Pages

- put `id` first
- put `class` second
- put the rest of the attributes afterward. makes reading easier.
- name the `id` like `<name>-<type>`, so `home-section` or `confirm-popup`
- at first give as many elements a unique id as possible. don't style the element in css using it's id though, unless it's a very specific page like `#landing-page` or something.  As your app grows you may need to refactor out the ids, but that will be a very easy task.  It is a lot harder to try to come up with a generic class-naming scheme up front when you don't know all of the variables.
- don't style anything by its tag name, beyond just setting up your initial style palette (default styling for `p` tags, for example). Instead, give it a class name, even if it's the same name as the tag: `<header class='header'>`.
- use localization up front, it's a good habit to get into, otherwise I've found you waste a good amount of time tracking down labels and trying to figure out why your navigation bar says "Home page" while the title says "Home Page" (where "Page" in the second case has a capital "P").

By maintaining this general structure, you can somewhat predict the number of HTML elements in your page (todo: calculation):

``` coffeescript
body ->
  header ->
    hgroup ->
      h1
      h2
  nav ->
  section ->
    header ->
      h2 ->
    div ->
    footer ->
  footer ->
```

## General Structure

``` coffeescript
section id: 'home-section', class: 'section', ->
  header class: 'header', ->
    h2 'Home'
  div class: 'content', ->
  footer class: 'footer', ->
```

The reason you always want to have a wrapping `<div class='content'>`, rather than having for example a `<table class='content'>` (if the only thing in your content area is a table), is because you don't want to have to override styles specific to the different elements in order to give it the same look (maybe you have 10px padding around your `<div class='content'>`, now if you don't wrap your table, you have to style your table differently, such as removing borders).

## Headers

``` coffeescript
# one level
header class: 'header', ->
  h2 'Home'

# two levels
header class: 'header', ->
  hgroup ->
    h2 class: 'title', 'Tower.js'
    h3 class: 'subtitle', 'A Web Framework'
```

You can remove the wrapper `<header>` tag if you're using the header inside of something like a content body (like a markdown document), but there's no real need to leave it out - that extra tag here and there doesn't come at any real performance cost.

## Footers

- For the top-level components, also give it an `id`, such as `<footer id='footer'>`

``` coffeescript
footer class: 'footer'
```

## Sidebars

``` coffeescript
aside class: 'sidebar'
```

## Popups

``` coffeescript
aside class: 'popup'
```

## Tab Navigators

Here are some different ways you might structure views:

``` coffeescript
ul class: 'tabs', ->
  li ->
    partial 'signup'
  li ->
    partial 'order'
    partial 'cart'
  li ->
    partial 'cart'
    partial 'total'
```

In that case, you want to reuse the same thing in multiple tabs.

## Rich(er) UI

Put use the extra `<span>` tags if you need the rich UI button look:
  
``` coffeescript
# this
dl ->
  dt 'Email'
  dd ->
    span 'example@localhost.com'
 
# vs. this
dl ->
  dt 'Email'
  dd 'example@localhost.com'
```