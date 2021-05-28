function [strikeP] = Bahrstrike_reframing (T,zxx,zxy,zyx,zyy,tetaj)

for j=1:length(tetaj)    
    
[c] = BahrCrit_reframing(j,T,zxx,zxy,zyx,zyy,tetaj);

difP(j)=c;

end

[Y,I]=min(difP);
strikeP=tetaj(I);
YP=Y;

