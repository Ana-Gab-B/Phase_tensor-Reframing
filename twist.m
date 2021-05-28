function [ztwi] = twist (t)
ztwi(1,1)=1;
ztwi(1,2)=-t;
ztwi(2,1)=t;
ztwi(2,2)=1;


ft=1/sqrt(1+t*t);
ztwi=ft*ztwi;


