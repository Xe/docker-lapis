docker-lapis
============

A dead simple `ONBUILD` image for your [Lapis](http://leafo.net/lapis) 
projects.

Usage
-----

```Dockerfile
FROM xena/lapis:2.1
```

Be sure to include an `app.yaml` manifest:

```yaml
name: "panel"

overlay:
 - apt-get update
 - apt-get install -y some-dependency

dependencies:
 - bcrypt
 - elfs
```

[![](http://puu.sh/egFMt/ee82453364.png)](https://asciinema.org/a/15303)
