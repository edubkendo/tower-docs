# @states "status", ->
#   @state "draft"
#   @state "published"
#   @state "archived"
#   
#   @event "publish", ->
#     @transition from: "draft", to: "published"
