all: shp/tl_2012_01001_roads.shp merged.shp

clean:
		rm -rf -- shp zip merged.*

zip/%.zip:
		mkdir -p $(dir $@)
		curl -o $@ http://www2.census.gov/geo/tiger/TIGER2012/ROADS/$*.zip

shp/%.shp: zip/%.zip
		mkdir -p $(dir $@)
		tar -xf zip/$*.zip -C shp/

merged.shp:
		while read line; do make shp/$$line.shp; done < "files";
		./merge.sh