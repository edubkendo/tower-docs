``` coffeescript
User.where(createdAt: ">=": 2.days().ago()).paginate(page: 10, limit: 20).all()
```