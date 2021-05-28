
function [zrot] = rot (teta)
tet=(pi/180)*teta;
zrot(1,1)=cos(tet);
zrot(1,2)=+sin(tet);
zrot(2,1)=-sin(tet);
zrot(2,2)=cos(tet);

