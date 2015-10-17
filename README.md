docker-lapis
============

A dead simple `ONBUILD` image for your [Lapis](http://leafo.net/lapis) 
projects.

Usage
-----

```Dockerfile
FROM xena/lapis:2.2
```

Be sure to include an `app.yaml` manifest:

```yaml
name: "panel"

overlay:
 - apt-get update
 - apt-get install -y some-ubuntu-dependency

dependencies:
 - bcrypt
 - elfs
```

[![](http://puu.sh/egFMt/ee82453364.png)](https://asciinema.org/a/15303)

This should cover 99% of usecases.

Postgres / etc. Support
-----------------------

This will spawn the `docker` configuration. Link the postgres container to your 
web app container and add the following to the nginx configuration and the 
`config.moon` file.

```nginx
# Environment variables
env PORT;
env POSTGRESQL_PORT_5432_TCP_PORT;
env POSTGRESQL_PORT_5432_TCP_ADDR;
env DB_USER;
env DB_PASS;
env DB_NAME;
```

```moonscript
-- config.moon
config "docker", ->
  port os.getenv "PORT"

  postgres ->
    backend "pgmoon"
    port os.getenv "POSTGRESQL_PORT_5432_TCP_PORT"
    host os.getenv "POSTGRESQL_PORT_5432_TCP_ADDR"
    user os.getenv "DB_USER"
    password os.getenv "DB_PASS"
    database os.getenv "DB_NAME"
```
