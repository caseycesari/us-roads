STATES = ak al ar az ca co ct dc de fl ga hi ia id il in ks ky la ma md me mi mn mo ms mt nc nd ne nh nj nm nv ny oh ok or pa ri sc sd tn tx ut va vt wa wi wv wy
TOPOJSON = node --max_old_space_size=8192 node_modules/.bin/topojson

all: png/us-roads.png

clean:
		rm -rf -- shp zip png topo

zip/%.zip:
		mkdir -p $(dir $@)
		curl -o $@ http://www2.census.gov/geo/tiger/TIGER2012/ROADS/$*.zip

shp/%.shp: zip/%.zip
		mkdir -p $(dir $@)
		unzip zip/$*.zip -d shp/

shp/%-roads.shp:
		mkdir -p $(dir $@)
		grep $* states.csv | cut -d \, -f 2 > temp
		while read line; do make shp/$$line.shp; done < "temp";
		@echo "merging county shapefiles"
		while read line; do if [ ! -f ./shp/$*-roads.shp ]; then ogr2ogr -f "ESRI Shapefile" ./shp/$*-roads.shp ./shp/$$line.shp; else ogr2ogr -f "ESRI Shapefile" -update -append ./shp/$*-roads.shp ./shp/$$line.shp -nln $*-roads; fi; done < "temp";
		rm temp

png/us-roads.png: $(addsuffix -roads.shp,$(addprefix shp/,$(STATES))) bin/rasterize
		mkdir -p $(dir $@)
		bin/rasterize $@
		optipng $@

topo/%-roads-unmerged.json: shp/%-roads.shp
		mkdir -p $(dir $@)
		$(TOPOJSON) -o $@ -- $(filter %.shp,$^)

topo/%-roads.json: topo/%-roads-unmerged.json
		bin/topomerge $< > $@