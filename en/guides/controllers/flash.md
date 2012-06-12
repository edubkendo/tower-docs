#Flash-Messages

The flash is a way to pass messages to your user that will appear on screen only once, then disappear when they change or refresh the page -- unless they do something to cause the message to be added back to the flash, like repeating the same error.  This feature is modeled on a similar feature that appears in both Rails and Express.  The code was modeled closely on Express's, but they function more closely to how they function in Rails --the developer can just *use* them, without needing to add dynamic helpers or create additional templates. 

##Usage

Using the flash is simple, just call @flash from your controller, and pass it one of three types "error", "success", or "info" followed by the message you want it to flash to your user.  For instance:

```coffeescript
  index: ->
    App.User.all (error, @users) =>
      @flash 'info', 'Hello!'
      @flash 'error', 'Danger Will Robinson!'
      @flash 'success', 'You Did It!!!!!'
      @render "index"
```

will produce the following:

![Three Flash Messages](https://github.com/edubkendo/flashMessages/raw/master/screenshots/flash_messages_demo.png "Three Flash Messages")

(Note the X's in the corner of each flash message. These come from twitter-bootstrap and allow the user to easily dismiss the messages if they don't want to continue looking at them.)

##Dynamic Usage

The flash message can also be generated dynamically, by allowing your program to determine when to call the @flash method based on conditional statements.

###Simple Case
For instance, in the simple case, let's assume a posts model with a simple validation for presence on the title field:

```coffeescript
class App.Post extends Tower.Model
  @field "title", type: "String"
  @field "body", type: "String"
  @field "userId", type: "Integer"

  @belongsTo "user"

  @validates 'title', presence: true

  @timestamps()
```

Currently, if the user forgets to fill in the title field, the app will simply fail silently.  This could be quite frustrating to a user, who doesn't understand why his post refuses to save.  We can solve that with a simple addition to the controller. In the "create" action of the posts controller, do this:

```coffeescript
  create: ->
    App.Post.create @params.post, (error, @post) =>
      if (k for own k, message of @post.errors).length isnt 0
        @flash 'error', message
        @render "new"
      else
        @render "show"
```

Now the user gets returned to the form, with what they have filled in so far left intact, and an easy to spot error message letting them know what they need to do to correct it.

![Flash Messages: Single Error](https://github.com/edubkendo/flashMessages/raw/master/screenshots/flash_message_with_single_error.png "Flash Message with single error")

Note that we can't just do a simple check on @posts.errors, because of a quirk in Javascript in which 

    {} === {} #false

returns false.  This would cause the form to need to be submitted twice each time, *regardless of whether there was an error or not.*

###More Complex Message Generation

What if there is more than one validation on the model. Let's assume a user model like this:

```coffeescript
class App.User extends Tower.Model
  @field "email", type: "String"
  @field "firstName", type: "String"
  @field "lastName", type: "String"

  @hasMany "posts"

  @validates 'lastName', 'email', presence: true

  @timestamps()
```

Still pretty simple, but this time, the validations check that two fields are completed.  In our controller we need to set up something like this:

```coffeescript
  create: ->
    App.User.create @params.user, (error, @user) =>
      if (k for own k of @user.errors).length isnt 0
        console.log @user.errors
        errString = ""
        num = 0
        for key, value of @user.errors
          num++
          errString = "#{errString} #{num}. #{value}"
        @flash 'error', errString
        @render "new"
      else
        @render 'show'
```

Now, if the user were to leave both the email and the last name fields blank, they would see something like:

![Flash Messages: Multiple Errors](https://github.com/edubkendo/flashMessages/raw/master/screenshots/flash_messages_errors.png "Flash Message with two errors")

While you can add one message to each of the flash types "error", "success", and "info", as well as create as many additional types as you desire (simply add them to the template in app/views/shared/_flash.coffee), any given type can only hold one message at a time, given the current instantiation. So, we need to build up the message we want to pass to it with some simple string concatenation.  This allows all of the error messages to be passed to the flash and shown in the browser when the user is returned to his form.

A note about the above, we could have saved a few lines, and had slightly cleaner looking code, by using the line:

    errString = "#{errString} <br /> #{value}"

Which would have placed a new line between each message, instead of numbering them on the same line. (Unfortunately, "\n" won't work here). However, I felt like for the wiki it would be best to use the safest example possible.

##About the Messages
The flash messages are styled with Twitter-Bootstrap, in keeping with the styling of the rest of Towerjs apps.  The template for the messages is stored in app/views/shared/_flash.coffee which is rendered from app/views/layouts/application.coffee .  Developers are, of course, free to alter the styling or templates, or remove them completely, as suits the needs of their particular projects.