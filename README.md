# Scenic - Multiple Database

This repository contains a basic Rails 6 app that combines multiple
database configurations with the
[Scenic](https://github.com/scenic-views/scenic) gem.

The repository includes branch heads at the following points:

* [pg-pg](https://github.com/mhw/scenic-multiple-database/tree/pg-pg):
  On this branch the app is configured with two Postgres database
  connections, `primary` and `legacy` in
  [`database.yml`](https://github.com/mhw/scenic-multiple-database/blob/pg-pg/config/database.yml).
  It also includes migrations that add tables and views to both of
  these databases.
  The current version of Scenic works correctly in this scenario.
  The migrations are in each connection's `migrations_paths` folder,
  and `rake db:migrate` correctly creates the views in the appropriate
  databases.

* [pg-mysql](https://github.com/mhw/scenic-multiple-database/tree/pg-mysql):
  On this branch the `legacy` database has been switched to MySQL.
  This causes Scenic to fail when the `schema.rb` file for the legacy
  database is being generated, even when it contains no views.
  I've filed a [GitHub issue](https://github.com/scenic-views/scenic/issues/291)
  for this.

* [pg-mysql-fix](https://github.com/mhw/scenic-multiple-database/tree/pg-mysql-fix):
  This branch adds an
  [initializer](https://github.com/mhw/scenic-multiple-database/blob/pg-mysql-fix/config/initializers/scenic.rb)
  that fixes the issue by choosing the correct Scenic adapter to match
  the database connection that is in use.

* [master](https://github.com/mhw/scenic-multiple-database/tree/master):
  The `master` branch pulls these threads together: it uses the initializer
  to add the [`scenic-mysql_adapter`](https://github.com/EmpaticoOrg/scenic-mysql_adapter)
  to the app, and also includes the additional migrations from the `pg-pg`
  branch. The fix in the initializer makes Scenic switch between the two
  adapters as necessary to make `rake db:migrate` work.
