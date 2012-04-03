- transactions
- undo/redo
- commit changes

- Scopes will bindable in ember, like DS.filter.  This means that "associations" are bindable, since they are scopes.  You know when an item is added or removed.

- Stores should have transactions that you can commit at the end of a large operation.

- should stores only be instantiated once, storing a bunch of types? maybe not.
  - pros: batch send data from one central location.
  - cons: everything has to take a 'type'