!SLIDE

# Metro.js #
## Rails for Node ##

!SLIDE

## For anyone new, I'm Lance ##

!SLIDE

## @viatropos ##

!SLIDE

## http://github.com/viatropos ##

!SLIDE subsection

# Model #

!SLIDE code

    @@@ coffeescript
    class User extends Metro.Model
      @key "firstName"
      @key "lastName"
      @key "email"
      
      @hasMany "posts"
      
      @validates "email", presence: true, format: true
     
!SLIDE

## All the cool bits of AR, Not of the DB requirements ##
## Makes writing other ORMs much easier ##

!SLIDE bullets incremental

* Callbacks
* Serialization
* Attribute Methods
* Validation
* Change Tracking
* Observers

!SLIDE

## http://github.com/rails/rails/tree/master/activemodel/ ##