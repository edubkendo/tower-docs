``` coffeescript
User.where(createdAt: ">=": 2.days().ago()).paginate(page: 10, limit: 20).all()
```

## Notes

- https://github.com/visionmedia/dm-pagination

``` html
<div class="pager">
  <a href="/items?page=1" class="first">First</a>
  <a href="/items?page=1" class="previous">Previous</a>
  <ul>
    <li class="page-1 first"><a href="/items?page=1" class="">1</a></li>
    <li class="active page-2"><a href="/items?page=2" class="">2</a></li>
    <li class="page-3 last"><a href="/items?page=3" class="">3</a></li>
    <li class="more">...</li>
  </ul>
  <a href="/items?page=3" class="next">Next</a>
  <a href="/items?page=5" class="last">Last</a>
</div>
```