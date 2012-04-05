# GeoSpatial Indexing with MongoDB

``` coffeescript
{ "location" : { "$near" : [50,50] }, "category" : "coffee" }
```

There is a Geolib for Node.js.

- [Geolib for Node](https://github.com/manuelbieh/Geolib)
- [Geolib usage example](https://gist.github.com/1300892)

Some functions include:

* getCenter(array coords) : Calculates the geographical center of the points
* isPointInside(object latlng, array coords)
* isPointInCircle(object latlng, object center, integer radius)
* orderByDistance(object latlng, mixed coords)
* findNearest ..
* and many more
