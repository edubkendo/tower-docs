# Database Feature Comparison

@@@ coffeescript
table ->
  thead ->
    th ->
      td ''
      td 'MongoDB'
      td 'CouchDB'
      td 'Cassandra'
      td 'Neo4j'
      td 'PostGreSQL'
      td 'MySQL'
      td 'SQLite3'
      td 'Redis'
  tbody ->
    tr ->
      td 'Type'
      td 'Document'
      td 'Document'
      td 'Document'
      td 'Graph'
      td 'SQL'
      td 'SQL'
      td 'SQL'
    tr ->
      td 'ACID Compliant'
@@@
