# BookshelfApi

A basic bookshelf management system to keep track of personal your personal
library.

The current release (v0.1) has basic CRUD support for creating and managing
books and authors. Authors are shared among all users and can be
modified/deleted by anyone, so be careful who you give access to.

A more appropriate authorization system for managing Authors is planned for
before a v1.0 release.

This backend API is meant to be used with a (forthcoming) Vue.js frontend.
Naturally other frontends are possible, but as the API isn't fixed consider it a
`v0`, despite the endpoints being labelled as `v1`.

## System Requirements

This Rails application was developed to the following target. Earlier/later
versions of some supporting software may work as well.

* ruby 2.6.3
* PostgreSQL 11.x
* Redis 5.x
* A Unix-like operating system

## Configuration

```
bundle install
rails db:create
rails db:setup
rails server
```

## Contributing

BookshelfApi includes an RSpec test suite and a Rubocop configuration.
Please ensure all of the tests pass and all of the files lint without warning
before submitting pull requests.

```bash
bin/rspec
bin/rubocop
```

TODO: Write more detailed/friendly contributing instructions including a Code of
Conduct.

## Deployment instructions

TODO: Write deployment instructions.
