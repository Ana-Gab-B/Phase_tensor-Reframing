function [zmx] = noisezM (zpri,pge)

zxx=zpri(1,1);
zxy=zpri(1,2);
zyx=zpri(2,1);
zyy=zpri(2,2);

srxx = real(zxy) * pge*randn(1);
rzxx = real(zxx) + srxx;
srxy = real(zxy) * pge*randn(1);
rzxy = real(zxy) + srxy;
sryx = real(zyx) * pge*randn(1);
rzyx = real(zyx) + sryx;
sryy = real(zyx) * pge*randn(1);
rzyy = real(zyy) + sryy;

sixx = imag(zxy) * pge*randn(1);
izxx = imag(zxx) + sixx;
sixy = imag(zxy) * pge*randn(1);
izxy = imag(zxy) + sixy;
siyx = imag(zyx) * pge*randn(1);
izyx = imag(zyx) + siyx;
siyy = imag(zyx) * pge*randn(1);
izyy = imag(zyy) + siyy;


zxx=complex(rzxx,izxx);
zxy=complex(rzxy,izxy);
zyx=complex(rzyx,izyx);
zyy=complex(rzyy,izyy);

szxx=complex(srxx,sixx);
szxy=complex(srxy,sixy);
szyx=complex(sryx,siyx);
szyy=complex(sryy,siyy);

zmx(1,1)=zxx;
zmx(1,2)=zxy;
zmx(2,1)=zyx;
zmx(2,2)=zyy;