# General Flow for Persisting Data in a `Tower.Store`

model.updateAttributes(attributes)
  @setAttributes(attributes)
  @scope().update @toUpdates(), (error) =>
    # @undoAttributes(attributes) if error DONT WANT THIS BEHAVIOR
    @store().update record, attributes, (error) =>
      @
  @resetAttributes(attributes)