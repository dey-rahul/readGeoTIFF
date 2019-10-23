function [Data Lat Lon]=readgeotiff(name,varargin)
%%
%
% readgeotiff - A simple function for reading geotiff files with integrated option to read
%        latitude-longitude data and subset using lat-lon limits.
%
%   Syntax -
%        Data=readgeotiff('Filename');
%        [Data Lat Lon]=readgeotiff('Filename');
%        [Data Lat Lon]=readgeotiff('Filename',[latlim],[lonlim]);
%
%
%   Input :-
%        Filename - name/path of the geotiff file
%        latlim - latitude limits in the format [minlat maxlat]
%        lonlim - longitude limits in the format [minlon maxlon]
%   Output :-
%        Data - geotiff image
%        Lat  - Latitude of centre of each grid point
%        Lon  - Longitude of centre of each grid point


%%
if (nargin==1 | nargin==3)
    if nargout==1
        Data=geotiffread(name);
    else
        
        Data=geotiffread(name);
        info=geotiffinfo(name);
        
        height = info.Height; % Height of the image
        width = info.Width; % Width of the image
        [rows,cols] = meshgrid(1:height,1:width);
        
        % Extract Lat-Lon values
        
        [x,y] = pix2map(info.RefMatrix, rows, cols);
        [Lat,Lon] = projinv(info, x,y);
        Lat=Lat'; Lon=Lon';
    end
    if nargin==3
        
        latlim=varargin{1};
        lonlim=varargin{2};
        
        if numel(latlim)==2 & numel(lonlim==2)
            
        l1=(Lat<min(latlim) | Lat>max(latlim));
        l2=(Lon<min(lonlim) | Lon>max(lonlim));
        
        l=l1+l2;
        l(l~=0)=1;
        
        ind=all(l);
        Data(:,ind,:)=[];
        Lat(:,ind)=[];
        Lon(:,ind)=[];
        l(:,ind)=[];
        
        ind=all(l');
        Data(ind,:,:)=[];
        Lat(ind,:)=[];
        Lon(ind,:)=[];
        else
        error('Incorrect map limits! Limits should be defined by two variables in the format [minlimit maxlimit]');
        end
    end
else
    error('Incorrect number of Inputs! Valid number of inputs is 1 or 3.');
end
