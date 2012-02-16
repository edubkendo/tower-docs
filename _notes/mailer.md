# Mailer

``` coffeescript
class Notifier extends Tower.Mailer
  @welcome: (user) ->
    @notification("welcome", name: user.firstName)

  @notification: (key, locals = {}) ->
    Notifier.defaultUrlOptions.host     = locals.host || "mysite.com"
    subject                             = Tower.t("emails.#{key}.subject", locals)
    from                                = locals.from || I18n.t("emails.from")
    to                                  = locals.to
    
    @mail from: from, to: to, subject: subject
```

Then you use it like this:

``` coffeescript
class User extends Tower.Model
  welcome: ->
    Notifier.notification(@).deliver()
```

## Redis for Email Background Jobs

Here's a pattern I use a lot

``` coffeescript
class User extends Tower.Model
  @welcome: (id) ->
    Notifier.notification(@constructor.find(id)).deliver()
    
  welcome: ->
    @constructor.async("welcome", @id)
```
