# Relation Metadata

All relations in Tower contain metadata that holds information about the relation in question, and is a valuable tool for third party developers to use to extend Tower.

You can access the metadata of the relation in a few different ways.

``` coffeescript
# Get the metadata for a named relation from the class or document.
Model.reflectOnAssociation("relationName")
model.reflectOnAssociation("relationName")

# Get the metadata that the current object has in its relation.
model.metadata()

# Get the metadata with a specific relation itself on a specific
# document.
person.addresses().metadata
```

## The Metadata Object

The metadata object itself contains more information than one might know what to do with.

- `Metadata#className`
- `Metadata#embedded?`
- `Metadata#extension`
- `Metadata#foreignKey`
- `Metadata#foreignKeyDefault`
- `Metadata#foreignKeySetter`
- `Metadata#indexed?`
- `Metadata#inverse`
- `Metadata#inverseForeignKey`
- `Metadata#inverseKlass`
- `Metadata#inverseSetter`
- `Metadata#inverseType`
- `Metadata#inverseTypeSetter`
- `Metadata#key`
- `Metadata#klass`
- `Metadata#macro`
- `Metadata#polymorphic?`
- `Metadata#setter`
- `Metadata#storesForeignKey?`
- `Metadata#validate?`
