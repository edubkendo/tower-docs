# Fakers

Fakers are used to generate random data.

- [Faker.js](https://github.com/marak/Faker.js/)
- [Faker.js screencast](http://thechangelog.com/post/607075727/faker-js-generate-fake-data-in-node-js-or-in-your)

``` coffeescript
Faker = require './Faker'
randomName = Faker.Name.findName() // Rowan Nikolaus
randomEmail = Faker.Internet.email() // Kassandra.Haley@erich.biz
randomCard = Faker.Helpers.createCard() // random contact card containing many properties
```