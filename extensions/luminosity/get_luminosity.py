######## Create zonal statistics of lights ########


##### Previous steps

# Importing libraries
import geopandas as gpd
import os
import rasterio
from pyproj import CRS
from rasterstats import zonal_stats


# Set working directory
os.chdir('/Users/gonzaloferres/GitHub/burgess_et_al_2015_replication/extensions/luminosity/')
    
# Define CRS
wgs84_crs = CRS.from_string('EPSG:4326') # WGS 1984

##### Create zonal statistics
lights = {}
years = list(range(1992, 2017 + 1))
for year in years:
    
    # Import lights data
    lights[year] = rasterio.open('./DMSP' + str(year) + '_bltcfix.tif')
    crs_raster = lights[year].crs
    
    # Import Kenyan 41 districts shapefile 
    kenya = gpd.read_file('geo2_ke1969/geo2_ke1969.shp')[['ADMIN_NAME', 'geometry']].set_crs(wgs84_crs).to_crs(crs_raster)
    
    
    array = lights[year].read(1)
    affine = lights[year].transform

    zs = zonal_stats(kenya, array, affine = affine, stats = ['mean', "sum"], nodata = -999, all_touched = True)
    kenya['new_bltcfix_light'] = [x['mean'] for x in zs]
    kenya['new_bltcfix_light_sum'] = [x['sum'] for x in zs]
    
    
    binary_array = array.copy()
    binary_array[binary_array > 0] = 1
    binary_array[binary_array == 0] = 0

    zs = zonal_stats(kenya, binary_array, affine = affine, stats=['mean', 'sum'], nodata = -999, all_touched = True)    
    kenya['new_bltcfix_pixsh'] = [x['mean'] for x in zs]
    kenya['new_bltcfix_sum'] = [x['sum'] for x in zs]
    
    
    # export to Stata
    del kenya['geometry']
    kenya['year'] = year
    kenya.to_stata('./new_bltcfix_light_loc' + str(year) + '.dta', write_index = False)

