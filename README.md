docker-lapis
============

A dead simple `ONBUILD` image for your [Lapis](http://leafo.net/lapis) 
projects.

Usage
-----

```Dockerfile
FROM xena/lapis
```

Be sure to include an `app.yaml` manifest:

```yaml
name: "panel"

dependencies:
 - moonscript
 - lapis
```

[![](http://puu.sh/egFMt/ee82453364.png)](https://asciinema.org/a/15303)
