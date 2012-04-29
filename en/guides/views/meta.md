# Meta Tags

``` coffeescript
meta 'title', 'keywords', 'description', 'copyright'
link 'pagination'
```

``` html
<meta name='description' content='140 characters' />
<meta name='keywords' content='ruby, jquery, node.js' />
<meta name='copyright' content='&copy; 2011 Lance Pollard. All rights reserved.' />
<meta name='robots' content='noodp,noydir,index,follow' />
<meta name='og:title' content='Storefront' />
<meta name='og:site_name' content='Storefront' />
<meta name='og:url' content='http://storefront.com' />
<meta name='og:image' content='http://storefront.com/images/logo.png' />
<meta name='og:description' content='2 sentences' />

<link rel="first" href="http://site.com/users" title="Users - Page 1" />
<link rel="prev" href="http://site.com/users?page=5" title="Users - Page 5" />
<link rel="next" href="http://site.com/users?page=7" title="Users - Page 7" />
<link rel="last" href="http://site.com/users?page=10" title="Users - Page 10" />
```
