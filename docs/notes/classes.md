    

stack: ->
  try
    throw new Error
  catch error
    return error.stack
    