# Widgets

## API

### Headers

#### Overview

Headers rendered inside of a widget look like this:

##### With a `subtitle`:

``` html
<header class='header'>
  <hgroup>
    <h3 class='title'></h3>
    <h4 class='subtitle'></h4>
  </hgroup>
</header>
```

##### Without a `subtitle`:

``` html
<header class='header'>
  <h3 class='title'></h3>
</header>
```

#### Configuration Options

#### Usage

``` coffeescript
widget "xyz", title: "I'm a title",                             # h3, or h#{defaultHeaderLevel}
widget "xyz", title: "I'm a title", subtitle: "I'm a subtitle", # h3, h#{defaultHeaderLevel + 1}
widget "xyz", headerHtml: {class: "my-header"}, titleHtml: {class: "menu-title"}, subtitleHtml: {class: "sub-title"}
widget "xyz", title: "I'm a title", level: 1                    # h1
```

## Examples

### List Widget

``` html
<nav>
  <header class='header'>
    <h3 class='title'></h3>
    <h4 class='subtitle'></h4>
  </header>
  <ul class='content list'>
    <li class='list-item'>
  
    </li>
  </ul>
</nav>
```

