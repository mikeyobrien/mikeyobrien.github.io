+++
title = "Setting up PostgreSQL on MacOS"
date = 2019-02-18
lastmod = 2020-04-11T17:30:20-05:00
draft = false
weight = 2001
+++

For this tutorial we will be using postgres.app from the folks at <https://eggerapps.at/> to install and setup a local development server on macOS.

Download and install using the instructions at <https://postgresapp.com/>

Start postgres from the applications folder
Ensure the CLI tools are working by typing,

```sh
createdb
```

This should result in the following error if everything was installed correctly,

```sh
createdb: database creation failed: ERROR: database "username" already exists
```

To create your development db enter into the console,

```sh
createdb devdb
```

If for whatever reason this db needs to be removed use,

```nil
dropdb devdb
```

Access the db we have just created,

```nil
psql devdb
```

This should drop you into an interactive terminal program where we will be able to enter, edit, and execute sql commands.

From here you can also execute internal psql commands beginning with the backslash character, "",
that are not SQL commands.

You can see what commands are available to you with the help command,

```sh
devdb=# help
You are using psql, the command-line interface to PostgreSQL.
Type:  \copyright for distribution terms
       \h for help with SQL commands
       \? for help with psql commands
       \g or terminate with semicolon to execute query
       \q to quit
```

[//]: # "Exported with love from a post written in Org mode"
[//]: # "- https://github.com/kaushalmodi/ox-hugo"
