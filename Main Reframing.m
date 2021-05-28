%%% Reframing program example from

%%% Reframing the magnetotelluric phase tensor for monitoring applications: improved
%%% accuracy and precision in strike determinations
%%% 

% Impedance functions should be loaded (ZXX_4E.m, ZXY_4E.m, ZYX_4E.m and ZYY_4E.m)

% The following parameters are needed for calculations
twg=0;
epg=0;
a=1;
b=1;
%Error percentages. 
p=10; %  error or 10% in this case
pge=p/100;
%Number of realizations
nrealiz=30;
%Number of sampling angles for penalty function.
nang=91;

for j=1:nang
    tetaj(j)=(j-1);% sampling angles for penalty function
end


%Constants definition 
kan=180/pi;
ki=1/kan;

ns=1; %Number of dataset

for is=1:ns
   
    [TT,zXx] = ZXX_4E(is);   %Dataset number (is) 
    [TT,zXy] = ZXY_4E(is);  
    [TT,zYx] = ZYX_4E(is); 
    [TT,zYy] = ZYY_4E(is);

    zxxo=zXx;zxyo=zXy; zyxo=zYx; zyyo=zYy;


    np=20;  %np = number of periods to make a window.

    nT=length(TT);   %nT = Available periods (from the impedances files) 

    nt=nT-np+1; % nt = number of estimations (according to available periods and size of window). 
                %Every estimation is a point in the figure.
 
    for it=1:nt % Iterations for estimations 
          
       for iT=1:np % Iterations for number of periods of the window. 
          T(iT)=TT(iT+it-1);
          zxxn(iT)=zxxo(iT+it-1);
          zxyn(iT)=zxyo(iT+it-1);
          zyxn(iT)=zyxo(iT+it-1);
          zyyn(iT)=zyyo(iT+it-1);
       end

     for j=1:nrealiz % Number of realizations  
         
        for i=1:np % Number of periods of the window
                   
            zpri(1,1)=zxxn(i);  % zpri is the impedance matrix for a given period
            zpri(1,2)=zxyn(i);
            zpri(2,1)=zyxn(i);
            zpri(2,2)=zyyn(i);
       
      % Redefinition of twist and shear 
            twi = tan(ki*twg); 
            shr=tan(ki*epg);
        %Definition of matrices
            [st] = sta (a,b);
            [tw] = twist (twi);
            [sh] = shear (shr);
                 
            [rt] = rot(0);
            [z2] = rt*zpri*rt';
            [prm] = z2;
            [prmn] = noisezM (prm,pge); % Noise for statistics
                 
                    % Construction of impedances from the tensor
                    zxx(i)=prmn(1,1); % Impedances + noise
                    zxy(i)=prmn(1,2);
                    zyx(i)=prmn(2,1);
                    zyy(i)=prmn(2,2);

        end
        % Strikes for all the realizations.
          
           [sP] = Bahrstrike_reframing (T,zxx,zxy,zyx,zyy,tetaj);
           
           
           strikeP(j) = sP; %Strikes for all the realizations  
           

     end

    % Mean and standard deviation

    
    mstrikeP(it)=mean(strikeP);
    sstrikeP(it)=std(strikeP)/sqrt(nrealiz);


    Tmean(it)=sqrt(TT(np+it-1)*TT(it));
    TT2(it)=TT(np+it-1);
    TT1(it)=TT(it);

    b(is,it)=mstrikeP(it);

    end

 % graphic
hold on
 
 errorbar(log10(Tmean),mstrikeP,sstrikeP,sstrikeP,'.-b')
 xlabel('Period','FontSize',12),ylabel('Degrees','FontSize',12)
 

end

