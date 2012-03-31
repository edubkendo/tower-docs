## Many-to-Many Relationships

Many to many relationships where the inverse documents are stored in a separate collection from the base document are defined using Tower's hasAndBelongsToMany macro. This exhibits similar behaviour to Active Record with the exception that no join collection is needed, the foreign key ids are stored as arrays on either side of the relation.

## Defining

Both sides of the relation use the same macro.

``` coffeescript
class User extends Tower.Model
  @field "name", type: "String"
  @hasAndBelongsToMany "comments"

class Comment extends Tower.Model  
  @field "body", type: "String"
  @hasAndBelongsToMany "users"
```

## Storage

When defining a relation of this nature, each document is stored in it's respective collection, and each document contains a "foreign key" reference to the other in the form of an array.

``` coffeescript
# The user document.
{
  "_id" : ObjectId("4d3ed089fb60ab534684b7e9"),
  "commentIds" : [ ObjectId("4d3ed089fb60ab534684b7f2") ]
}

# The comment document.
{
  "_id" : ObjectId("4d3ed089fb60ab534684b7f2"),
  "userIds" : [ ObjectId("4d3ed089fb60ab534684b7e9") ]
}
```

## Accessors

Accessing the relations is handled through the methods created based on the names of the relations. The following example shows basic access on both sides of the relation.

``` coffeescript
# Return the comments().
user.comments().all()

# Set the comments from the user.
user.comments().set([new Comment])

# Return the user from the comment.
comment.user()

# Set the user from the comment.
comment.user().set(new User)

## Building and Creating

From either side, documents in the referenced inverse can be appended to using traditional array syntax or the special association proxy methods.

``` coffeescript
# Append one or many comments, saving them if the user is persisted.
user.comments().create(new Comment)
user.comments().push(new Comment)

# Appends and returns a new comment from the attributes.
user.comments().build(name: "Buch")
user.comments().new(name: "Buch")

# Appends, saves, and returns a new comment from the attributes.
user.comments().create(name: "Bar")

# Appends, saves, and returns a new comment from the attributes,
# raising an error if validation fails.
user.comments().create!(name: "Bar")

# Append one or many users, saving them if the comment is persisted.
comment.users().build(new User)
comment.users().push(new User)

# Appends and returns a new user from the attributes.
comment.users().build(title: "Mr")
comment.users().new(title: "Mr")

# Appends, saves, and returns a new user from the attributes.
comment.users().create(title: "Sire")

# Appends, saves, and returns a new user from the attributes,
# raising an error if validation fails.
comment.users().create!(title: "Douchebag")
REMOVAL

Documents in the relation can be removed in several different manners, either through the relation, criteria, or accessors.
# Delete all referenced documents
user.comments().delete()
user.comments().clear
user.comments.set([])

# Delete all matching referenced documents.
user.comments().where(name: "Rails").delete()
```

## Dependent Behavior

You can tell Tower what to do with inverse relations of a many to many when unsetting the relation via the dependent option. This also applies to calling #delete on the relation. The valid options are:

:delete: Delete the inverse documents.
:destroy: Destroy the inverse documents.
:nullify: Orphan the inverse documents.
class User
  include Tower::Document
  hasAndBelongsToMany :preferences, dependent: :nullify
end

# Orphan all the inverse relations:
user.preferences = []
user.preferences = nil

# Orphan a single child relation:
user.preferences.delete(preference)
If the dependent option is not defined, the default is to nullify.
