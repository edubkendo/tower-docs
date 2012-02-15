
# http://apidock.com/rails/ActiveRecord/Associations/ClassMethods/belongs_to
# hasMany "articles", type: "Post"
# 
# @param foreignKey
# @param primaryKey
# @param dependent [false]
# @param counterCache [false]
# @param cache [false]
# @param readOnly [false]
# @param validate [false]
# @param autoSave [false]
# @param touch [false]
# @param inverseOf [false]
# @param polymorphic [false]
# @param default [false]

## Todo

- The `dependent` option
- The `counterCache` in all situations
- Record cache for relations (IdentityMap).  Only really needed server-side
- A `transaction` api
- The `reset` method
- The `reload` method
- Eager loading

## Differences from Rails

- Doesn't have dynamic finders.  Pros, cuts down on javascript/memory, and it's a more consistent, clear api.  Cons, don't get to play around with magic.

## Other

``` coffeescript
applyFinderOptions: (options) ->
  relation = clone
  return relation unless options
  
  options.assertValidKeys(@constructor.VALID_FIND_OPTIONS)
  finders = options.dup
  finders.deleteIf { |key, value| value.nil? && key != :limit }

  ([:joins, :select, :group, :order, :having, :limit, :offset, :from, :lock, :readonly, :eagerLoad] & finders.keys).each do |finder|
    relation = relation.send(finder, finders[finder])
  end

  relation = relation.where(finders[:conditions]) if options.hasKey?(:conditions)
  relation = relation.includes(finders[:include]) if options.hasKey?(:include)
  relation = relation.extending(finders[:extend]) if options.hasKey?(:extend)

  relation

# Removes any condition from the query other than the one(s) specified in +onlies+.
#
# Example:
#
#   Post.order('id asc').only(:where)         # discards the order condition
#   Post.order('id asc').only(:where, :order) # uses the specified order
#
only: (onlies...) ->
result = self.class.new(@klass, table)
result.defaultScoped = defaultScoped

((Relation::ASSOCIATION_METHODS + Relation::MULTI_VALUE_METHODS) & onlies).each do |method|
  result.send(:"#{method}_values=", send(:"#{method}_values"))
end

(Relation::SINGLE_VALUE_METHODS & onlies).each do |method|
  result.send(:"#{method}_value=", send(:"#{method}_value"))
end

# Apply scope extension modules
result.send(:applyModules, extensions)

result

# Removes from the query the condition(s) specified in +skips+.
#
# Example:
#
#   Post.order('id asc').except(:order)                  # discards the order condition
#   Post.where('id > 10').order('id asc').except(:where) # discards the where condition but keeps the order
#
except: (skips...) ->
result = self.class.new(@klass, table)
result.defaultScoped = defaultScoped

((Relation::ASSOCIATION_METHODS + Relation::MULTI_VALUE_METHODS) - skips).each do |method|
  result.send(:"#{method}_values=", send(:"#{method}_values"))
end

(Relation::SINGLE_VALUE_METHODS - skips).each do |method|
  result.send(:"#{method}_value=", send(:"#{method}_value"))
end

# Apply scope extension modules
result.send(:applyModules, extensions)

result
```

## Notes


expect(attributes).toNotEqual { userId: 1, userIds: [1] }
Post.hasMany "users", cache: true
User.hasMany "posts", cache: true, inverseOf: "users", polymorphic: true, counterCache: true
Use `cache` when you don't care about _when_ the association was created, you just want the ids
expect(attributes).toEqual { userIds: [1] }
expect(attributes).toEqual { postIds: [{id: 1, type: "BlogPost"}], postCount: 10 }

This is right, but maybe you shouldn't be allowed?
Post.hasMany "users", cache: true, polymorphic: true
User.hasMany "posts", cache: true, counterCache: true
expect(attributes).toEqual { userIds: [{id: 1, type: "User"}] }
expect(attributes).toEqual { postIds: [1], postCount: 10 }

This is right
User.hasMany "posts"
Post.belongsTo "user", embed: true
expect(attributes).toEqual { posts: [{id: 1, createdAt: Date}], postCount: 1 }

This is right
User.hasMany "posts"
Post.belongsTo "user"
expect(attributes).toEqual { }
expect(attributes).toEqual { userId: 1 }

This is right
User.hasMany "posts", cache: true
Post.belongsTo "user"
expect(attributes).toEqual { postIds: [1] }
expect(attributes).toEqual { userId: 1 }

DOESNT WORK, BOTH MUST BE CACHE!  Well, it will work because auto-infer cache from relationship (if either has it and they're both hasMany)
User.hasMany "posts"
Post.hasMany "users", cache: true
expect(attributes).toEqual { }
expect(attributes).toEqual { userIds: [1] }

DOES WORK!
User.hasMany "posts", cache: true
Post.hasMany "users", cache: true
expect(attributes).toEqual { postIds: [1] }
expect(attributes).toEqual { userIds: [1] }

Post.hasMany "users", cache: true
User.hasMany "posts", cache: true, inverseOf: "users", polymorphic: true, counterCache: true
expect(attributes).toEqual { id: 0, userId: 1, postId: 1 }
expect(attributes).toEqual { }
expect(attributes).toEqual { }

This is right
User.hasMany "postings"
User.hasMany "posts", through: "postings"
Post.hasMany "postings"
Post.hasMany "users", through: "postings"
Posting.belongsTo "user"
Posting.belongsTo "post"
expect(attributes).toEqual { id: 0, userId: 1, postId: 1 }
expect(attributes).toEqual { }
expect(attributes).toEqual { }

If `embed` is specified on either side of the relationship it's used
User.hasMany "postings"
User.hasMany "posts", through: "postings"
Post.hasMany "postings"
Post.hasMany "users", through: "postings"
Posting.belongsTo "user", embed: true
Posting.belongsTo "post", embed: true
expect(attributes).toEqual { postings: [{id: 1, postId: 1}] }
expect(attributes).toEqual { postings: [{id: 1, userId: 10}] }

If `embed` is specified on either side of the relationship it's used
User.hasMany "postings"
User.hasMany "posts", through: "postings"
Post.hasMany "postings"
Post.hasMany "users", through: "postings"
Posting.belongsTo "user"
Posting.belongsTo "post", embed: true
expect(attributes).toEqual { postings: [{id: 1, postId: 1}] }
expect(attributes).toEqual { }

If `embed` is specified on either side of the relationship it's used
User.hasMany "postings", embed: true
User.hasMany "posts", through: "postings"
Post.hasMany "postings"
Post.hasMany "users", through: "postings"
Posting.belongsTo "user"
Posting.belongsTo "post"
expect(attributes).toEqual { postings: [{id: 1, postId: 1}] }
expect(attributes).toEqual { }

The above 4 produce the same results

- Removing `hasMany through` because it requires way too much abstraction, and it limits you a TON.  Not worth the time or overhead right now.

I personally think it's better to explicitly define and manage the "through" model.  Take `User -> Membership -> Group`.  There's many potential ways to write this:

``` coffeescript
# Rails 2.3 syntax, implicit/generated/internal "membership" model (called `users_groups`)
User.hasAndBelongsToMany "groups"
Group.hasAndBelongsToMany "users"

# hasMany through
User.hasMany "memberships"
User.hasMany "groups", through: "memberships"
Group.hasMany "memberships"
Group.hasMany "users", through: "memberships"

# manually define the query
User.hasMany "memberships"
User.hasMany "groups", -> @anyIn(id: _.map(@memberships().all(), (membership) -> membership.get("groupId")))
```

At some point that may be refactored into a `through` api, but right now it's overly complex.