# Set environment variables

export PGHOST=postgis
export PGUSER=$POSTGRES_USER
export PGPASSWORD=$POSTGRES_PASS
export PGPORT="5432"
export PGDATABASE=$POSTGRES_DBNAME

schema="public"
tabblock_projection=4269

SOURCE_DIR='./downloads'
ZIP_DIR="./unzipped"

find ./ -name '*.zip' -exec sh -c 'unzip -u -d "${1%.*}" "$1"' _ {} \;

for shapefile in $(find downloads/ -type f -name '*.shp');
 do
   tablename="$(basename "$shapefile" .shp)"
   echo $tablename
   shp2pgsql -d -I -s $tabblock_projection $shapefile $schema.$tablename| psql
 done
