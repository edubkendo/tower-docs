# Create named scope class method finders for a model.
#
# @example Add scope to a User model
# 
#     class User
#       @scope "active",      @where(active: true)
#       @scope "recent",      @where(createdAt: ">=": 2.days().ago()).order("createdAt", "desc").order("email", "asc")
#       @scope "developers",  @where(tags: _anyIn: ["ruby", "javascript"])
# 

# ## Examples
# 
#     # delete users 1, 2, and 3
#     User.delete 1, 2, 3, (error, records)
#     User.delete [1, 2, 3], (error, records)
#     User.delete [1, 2, 3], (error)
#     User.delete 1, 2, 3, {instantiate: false, validate: false}, (error)
#     User.delete {instantiate: false, validate: false}, (error)
#

# ## Examples
#
#     User.update 1, 2, 3, name: "John", (error, records)
#     User.update 1, 2, 3, name: "John", (error)
#     User.update [1, 2, 3], name: "John", (error, records)
#     User.update [1, 2, 3], name: "John", (error)
#     User.update name: "John", (error, records)
#     User.update name: "John", (error)
#     User.update 1, 2, 3, {name: "John"}, {instantiate: false, validate: false}, (error)
#     User.update {name: "John"}, {instantiate: false, validate: false}, (error)
#

# ## Examples
#
#     User.create name: "John", (error, record)
#

# find(1)
# find(1, 2, 3)


# @param only
# @param include
# @param except
# @param methods
# 
#     @user.toJSON
#       include:
#         posts:
#           include:
#             taggings:
#               include:
#                 tag:
#                   only: "name"