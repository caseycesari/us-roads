# U.S. Roads

![us-roads]()

A fork of [Mike Bostock](https://github.com/mbostock)'s awesome [us-rivers](https://github.com/mbostock/us-rivers) project, but for roads. 

Uses 2012 [TIGER/Line](http://www.census.gov/geo/maps-data/data/tiger-line.html) road data. Inspired by and a re-creation of [Fathom Information Design](http://fathom.info/)'s [All Streets](http://fathom.info/allstreets) print.

To install:

```bash
brew install p7zip cairo pixman optipng
npm install
```

If the installation of the [node-canvas](https://github.com/LearnBoost/node-canvas) module fails for you, you can try this after the above:

```bash
PKG_CONFIG_PATH=/opt/X11/lib/pkgconfig npm install canvas
```

See the [wiki](https://github.com/LearnBoost/node-canvas/wiki) for more install help.

To make the above PNG for the entire United States, type `make`. 

Make a TopoJSON file for a specific state:

```bash
make topo/pa.json
```

Make a Shapefile for a specific state:

```bash
make shp/wa.json
```