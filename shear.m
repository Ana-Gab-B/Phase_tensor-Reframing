function [smat] = shear (e)
smat(1,1)=1;
smat(2,1)=e;
smat(1,2)=e;
smat(2,2)=1;

fe=1/sqrt(1+e*e);
smat=fe*smat;


