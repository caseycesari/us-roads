#!/bin/sh
mkdir merged

for f in $(ls shp/*.shp) 
  do
  if [ ! -f ./merged/merged.shp ]; then
    ogr2ogr -f "ESRI Shapefile" ./merged/merged.shp $f
  else
    ogr2ogr -f "ESRI Shapefile" -update -append ./merged/merged.shp $f -nln merged
  fi
done