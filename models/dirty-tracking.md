# Dirty Tracking

Tower supports tracking of changed or "dirty" fields with an API that mirrors that of Active Model. If a defined field has been modified in a model the model will be marked as dirty and some additional behaviour comes into play.
VIEWING CHANGES

There are various ways to view what has been altered on a model. Changes are recorded from the time a document is instantiated, either as a new document or via loading from the database up to the time it is saved. Any persistence operation clears the changes.
class Person extends Tower.Model
  field :name, type: String

person = Person.first
person.name = "Alan Garner"

# Check to see if the document has changed.
person.changed? #=> true

# Get an array of the names of the changed fields.
person.changed #=> [ :name ]

# Get a hash of the old and changed values for each field.
person.changes #=> { "name" => [ "Alan Parsons", "Alan Garner" ] }

# Check if a specific field has changed.
person.name_changed? #=> true

# Get the changes for a specific field.
person.name_change #=> [ "Alan Parsons", "Alan Garner" ]

# Get the previous value for a field.
person.name_was #=> "Alan Parsons"
RESETTING CHANGES

You can reset changes of a field to it's previous value by calling the reset method.
person = Person.first
person.name = "Alan Garner"

# Reset the changed name back to the original
person.reset_name!
person.name #=> "Alan Parsons"
NOTES ON PERSISTENCE

Tower uses dirty tracking as the core of its persistence operations. It looks at the changes on a document and atomically updates only what has changed unlike other frameworks that write the entire document on each save. If no changes have been made, Tower will not hit the database on a call to Model#save.
VIEWING PREVIOUS CHANGES

After a document has been persisted, you can see what the changes were previously by calling Model#previous_changes
person = Person.first
person.name = "Alan Garner"
person.save #=> Clears out current changes.

# View the previous changes.
person.previous_changes #=> { "name" => [ "Alan Parsons", "Alan Garner" ] }