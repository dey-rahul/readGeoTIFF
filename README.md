 A simple function for reading geotiff files with integrated option to read
        latitude-longitude data and subset using lat-lon limits.

   Syntax -
        Data=readgeotiff('Filename');
        [Data Lat Lon]=readgeotiff('Filename');
        [Data Lat Lon]=readgeotiff('Filename',[latlim],[lonlim]);


   Input :-
        Filename - name/path of the geotiff file
        latlim - latitude limits in the format [minlat maxlat]
        lonlim - longitude limits in the format [minlon maxlon]
   Output :-
        Data - geotiff image
        Lat  - Latitude of centre of each grid point
        Lon  - Longitude of centre of each grid point
