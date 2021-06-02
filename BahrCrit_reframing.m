
function [difP] = BahrCrit_reframing(j,T,zxx,zxy,zyx,zyy,tetaj)

smsP=0;
mu0=4*pi*10^-7;
cte=sqrt(mu0*2*pi);

for i=1:length(T) 
cte=cte/sqrt(T(i)); 

R= rot (tetaj(j));
Zm(1,1)=zxx(i)/cte;
Zm(1,2)=zxy(i)/cte;
Zm(2,1)=zyx(i)/cte;
Zm(2,2)=zyy(i)/cte;
prm=R*Zm*R';


%Phase Tensor
Rprm=real(Zm);
Iprm=imag(Zm);
Phtr=inv(Rprm)*Iprm;
ratio=(Phtr(1,2)-Phtr(2,1))/(Phtr(1,1)+Phtr(2,2));
Beta=(180/pi)*0.5*atan(ratio);
RB= rot (2*Beta);
Pt=R*Phtr*RB'*R';


%smsP = smsP+ abs(Pt(1,2)) + abs(Pt(2,1)); % This row is for norm L1 
smsP = smsP+ Pt(1,2)*Pt(1,2) + Pt(2,1)*Pt(2,1); % This row is for norm L2


end

difP=smsP/length(T);
