-- Create extensions to permit it

CREATE EXTENSION IF NOT EXISTS postgis;
CREATE EXTENSION IF NOT EXISTS fuzzystrmatch;
CREATE EXTENSION IF NOT EXISTS postgis_tiger_geocoder;
--this one is optional if you want to use the rules based standardizer (pagc_normalize_address)
CREATE EXTENSION IF NOT EXISTS address_standardizer;

-- Create loading profile for geocoding data

DELETE FROM tiger.loader_platform AS tl
WHERE tl.os ='siege';

INSERT INTO tiger.loader_platform(os, declare_sect, pgbin, wget, unzip_command, psql, path_sep,
                                  loader, environ_set_command, county_process_command)
SELECT 'siege',
       declare_sect,
       pgbin,
       wget,
       unzip_command,
       psql,
       path_sep,
       loader,
       environ_set_command,
       county_process_command
FROM tiger.loader_platform
WHERE os = 'sh';

UPDATE tiger.loader_variables AS tlv
SET staging_fold = '/tmp/gisdata';

SELECT * FROM tiger.loader_variables;
-- Update loading profile to use ZIPS

UPDATE tiger.loader_lookuptables SET load = true WHERE table_name = 'zcta510';