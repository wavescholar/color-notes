function [a,g,ea,eg,yr,yg,yb,yw,chro_guns,chro_whites]=calibrat(fig,Nm,Msx,tray,busca);

% CALIBRAT: Procedure for (manual and tedious) monitor calibration 
%
% Computers do not use an appropriate (colorimetrically meaningful)
% description of color, but 3D arrays of parameters n=[n1 n2 n3]
% that control the voltages of each gun of the CRT. 
% In most standard image formats these 'ni' values (digital values) 
% are given using 8 bit integers (uint8 variables ranging from 0 to 255).
% This is a device-dependent characterization because the color 
% obtained from a given array, n, depends on the particular color reproduction
% device.
% 
% In MATLAB colormaps the digital values that describe the colors are 
% real numbers with values in [0,1] (ranging from minimum luminance to 
% maximum luminance of the gun).
%
% Some calibration data are needed to relate these device-dependent 
% values to colorimetrically meaningful (device-independent) values.
% In this way we will be able to generate accurate colors in our CRT 
% monitor.
% Besides, we will be able to estimate the tristimulus components of 
% the digital images from their digital encoding.
% 
% The 'COLORLAB format for CRT calibration data storage' is just a name 
% convention for the variables involved in the CRT calibration. 
% Such a convention is covenient for future automatic transform of the 
% data to the required color system when using LOADMON.M
% 
% COLORLAB assumes additivity and independence between the guns of the CRT monitor.
% COLORLAB also assumes an exponential relation (gamma relation) between 
% the luminance of the gun, i, and the corresponding digital value, n_i (i=1,2,3).
% COLORLAB makes no assumption on the chromaticities of the guns (that may depend 
% on the digital value in any complex way).
% 
% With these assumptions, the calibration data include:
%
% - Chromaticities of the gun, i, as a function of the digital step, n_i.
% - Parameters (a_i and g_i) of the gamma relation between the luminance of 
%   the gun, i, and the digital value, n_i:    
%
%                           Y_i=a_i*n_i^g_i 
% 
% A typical VGA-like card will discriminate 256 steps in each gun.
% 
% The calibration process consists of measuring samples of these 
% curves (generating a number of stimuli and measuring the corresponding colors)
% and using these samples to fit the parameters a,g of the curves.
% 
% CALIBRAT generates the stimuli in each gun, asks for the chromaticity 
% and luminance values and fits the curves. This procedure is repeated 
% for each gun. The process is also done for white (gray) stimuli in order
% to check the additivity of the guns.
%
% The program returns the parameters of the luminance curves (a,g), their 
% errors (ea,eg) and the luminances of the guns and the white stimuli.
% Besides, CALIBRAT returns two matrices with the data of the chromaticities 
% of the guns and the white stimuli:
%
%  * tm = 7*N matrix with the chromaticities of the monitor guns (primaries). 
%         This 7*N format is referred to as calibration data in other routines help.
%
%  * tw = 3*N matrix with the chromaticities of the white stimuli. 
%
% As an example, if we select ni to be ni=0:0.1:1 we will have: 
% 
%       /    0         0.1      ......    0.9           1     \
%      | t1(P1(0))  t1(P1(0.1)) ...... t1(P1(0.9))  t1(P1(1))  |
%      | t2(P1(0))  t2(P1(0.1)) ...... t2(P1(0.9))  t2(P1(1))  |  
%      | t1(P2(0))  t1(P2(0.1)) ...... t1(P2(0.9))  t1(P2(1))  |  
% tm = | t2(P2(0))  t2(P2(0.1)) ...... t2(P2(0.9))  t2(P2(1))  |  
%      | t1(P3(0))  t1(P3(0.1)) ...... t1(P3(0.9))  t1(P3(1))  |  
%       \t2(P3(0))  t2(P3(0.1)) ...... t2(P3(0.9))  t2(P3(1)) /
%
% and,
%
%       /    0        0.1     ......    0.9         1      \
% tw = |  t1(W(0))  t1(W(0.1)) ...... t1(W(0.9))  t1(W(1))  |
%       \ t2(W(0))  t2(W(0.1)) ...... t2(W(0.9))  t2(W(1)) /
%
% If the colorimeter gives no chromaticity measure for low digital values,
% introduce [0 0] for these chromaticities.  
% For those digital values below the sensitivity of the colorimeter we will
% interpolate the chromaticities between the first measured value and the 
% chromaticity of zero ([0 0 0]).
% The chromaticity asignated to [0 0 0] is the one of the first measurable 
% white.
%
%  SYNTAX
%  ---------------------------------------------------------------------------------------
%  
%  [a,g,ea,eg,yr,yg,yb,yw,tm,tw]=calibrat(fig,ni,Msx,'path',look_for_data?);
%  
%  
%  INPUT variables:
%
%  fig    = figure (number) where the stimuli will be generated.
%
%  ni     = 1*N vector with the digital values that will be measured. 
%           ni MUST include 0 and 1. 
%           For example, if you want to measure the colors in N equally
%           spaced points for each gun, you could enter ni=linspace(0,1,N);
%
%  Msx    = 3*3 change-of-basis matrix that relates the system S (where the data
%           are expressed in) to the CIEXYZ system.
%
%  'path' = String with the path to the file that will contain the data. For example:
%           'c:\matlab\toolbox\colorlab\colordat\monitor\monito.mat'
%
%  look_for_data = Tells the program if there are previously measured data.
%           Calibration is a tedious process (tipically you will have to measure
%           and type 24 to 32 colors  -6 to 8 per gun plus the whites-).
%           CALIBRAT automatically saves each measure in the provided file, so
%           if something happens you dont have to measure again. 
%           If look_for_data==1, CALIBRAT looks for the previously measured data (in 'path'),
%           and only generates the stimuli you need to finish the series of measurements.
%           If look_for_data==0, it starts a new (complete) series of measurements.
%           
%  OUTPUT variables:
% 
%  a      = 1*3 vector including the constants a_i of the gamma relation for each gun.
%
%  g      = 1*3 vector including the constants g_i of the gamma relation for each gun.
%
%  ea     = 1*3 vector including the errors of the constants a_i of the gamma relation.
%
%  eg     = 1*3 vector including the errors of the constants g_i of the gamma relation.
%
%  yr     = 1*N vector containing the N luminance measures for the Red Gun.
%
%  yg     = 1*N vector containing the N luminance measures for the Green Gun.
%
%  yb     = 1*N vector containing the N luminance measures for the Blue Gun.
%
%  yw     = 1*N vector containing the N luminance measures for the white stimuli.
%
%  tm     = 7*N matrix that contains the chromaticities of the R, G and B guns for 
%           N calibration points of the digital value.
%           The chromaticities are given in the system at hand even though they are 
%           stored in the CIEXYZ system (this is why Msx is needed). 
%
%  tw     = 3*N matrix that contains the chromaticities of the white stimuli for 
%           N calibration points of the digital value.
%           The chromaticities are given in the system at hand eventhough they are 
%           stored in the CIEXYZ system (this is why Msx is needed). 
%  
%  REQUIRED FUNCTIONS (Routines with * are required for the fit only)
%  ---------------------------------------------------------------------------------------
%  coor2tri.m   sacagama.m*   ajusta1.m*     error1.m*   funcion.m*
%  newbasis.m     justa1.m*   grafic1.m*   derivad2.m*
%
%

if nargin==4 busca=0;end
clc
disp('  ')
disp('  ')
disp('  MONITOR CALIBRATION')
disp('  ')
disp('  STIMULI GENERATION AND MEASUREMENT')
disp('  ')
disp('    Put the colorimeter in front of the screen')
disp('    and enter the chromaticities and luminance')
disp('    [t1 t2 Y]')
disp('  ')
disp('    (Press any key to continue...)')
pause

%p=round(nptos);
%Nm=round(Nm);
%if p(1)~=0
%   p=[0 p];
%end
%if p(length(p))~=Nm
%   p=[p Nm];
%end

nptos=length(Nm);

if busca==1
   eval(['load ',tray])
   s=size(y);
   prim=s(1);
   nivi=ones(1,4);
   if sum(y(prim,:))>0
      niv=find(y(prim,:)==0)
      ss=size(niv);
      if (niv(1)==1)&(prod(ss)>1)
         niv=niv(2);
      else       
         niv=niv(1);
      end      
   else
      niv=1;
   end
   nivi(prim)=niv;  
else   
   prim=1;
   nivi=ones(1,4);
end


for i=prim:4
    if i<4
       for j=nivi(i):nptos
           clc
           disp('  ')
           disp('  ')
           disp('  MONITOR CALIBRATION')
           disp('  ')
           disp(['  GUN ',int2str(i),': DIGITAL VALUE [0,1] ',num2str(  Nm(j) )])
           disp('  ')
           disp('  ')
           n=[0 0 0];
           n(i)=Nm(j);
           calibra(n,0.5,fig);
           k=0;
           while k==0
             l=input('    Chromatic coordinates and luminance(cd/m2)? [t1 t2 Y] ');
             disp('  ')
             corr=input('    Are you sure? (1=yes / 0=no)  ');
             disp('  ')         
             if corr==1
                k=1;
                y(i,j)=l(3);
                chro_guns(2*i-1,j)=l(1);
                chro_guns(2*i,j)=l(2);
                eval(['save ',tray])
             else
                k=0;
             end
           end
        end
    else
       for j=nivi(i):nptos
           clc
           disp('  ')
           disp('  ')
           disp('  MONITOR CALIBRATION')
           disp('  ')
           disp(['  WHITE: DIGITAL VALUE ',num2str( Nm(j) )])
           disp('  ')
           disp('  ')
           n=Nm([j j j]);
           calibra(n,0.5,fig);
           k=0;
           while k==0
             l=input('    Chromatic coordinates and luminance(cd/m2)? [t1 t2 Y] ');
             disp('  ')
             corr=input('    Are you sure? (1=yes / 0=no)  ');
             disp('  ')         
             if corr==1
                k=1;
                y(i,j)=l(3);
                chro_whites(:,j)=[l(1);l(2)];
                eval(['save ',tray])
             else
                k=0;
             end
           end
        end
    end
end

bla=sum(double(prod(chro_whites(1:2,:))==0))+1;
crobla0=chro_whites(1:2,bla);	
ro=sum(double(prod(chro_guns(1:2,:))==0))+1;
croro0=chro_guns(1:2,ro);
ver=sum(double(prod(chro_guns(3:4,:))==0))+1;
crover0=chro_guns(3:4,ver);
az=sum(double(prod(chro_guns(5:6,:))==0))+1;
croaz0=chro_guns(5:6,az);
if ro>1
   for i=1:ro-1
       chro_guns(1:2,i)=crobla0+(chro_guns(1:2,ro)-crobla0)*(i-1)/(ro-1);
   end
end 
if ver>1
   for i=1:ver-1
       chro_guns(3:4,i)=crobla0+(chro_guns(3:4,ver)-crobla0)*(i-1)/(ver-1);
   end
end
if az>1
   for i=1:az-1
       chro_guns(5:6,i)=crobla0+(chro_guns(5:6,az)-crobla0)*(i-1)/(az-1);
   end
end
if bla>1
   chro_whites(:,1:bla-1)=crobla0*ones(1,bla-1);
end

clc
disp('  MONITOR CALIBRATION')
disp('  ')
disp('  CURVE FIT')
disp('  ')
disp('    Now CALIBRAT will fit the parameters')
disp('    of the curves Y_i=a_i*n_i^g_i')
disp('    ')
disp('    * First you will see some flickering numbers (the fit!) ')
disp('    * Then the fitted curves will show up')
disp('  ')
disp('    (Press any key to continue...)')
pause
[a,ea,g,eg]=sacagama([Nm;Nm;Nm],y(1:3,:),700,fig+1);
yr=y(1,:);
yg=y(2,:);
yb=y(3,:);
yw=y(4,:);

chro_guns=[Nm;chro_guns];
chro_whites=[Nm;chro_whites];

clc
disp('  MONITOR CALIBRATION')
disp('  ')
disp('  ADDITIVITY CHECK')
disp('  ')
disp('    CALIBRAT now represents the sum')
disp('    of the gun luminances and the luminance')
disp('    of the corresponding white in order to')
disp('    check the additivity assumption')
disp('  ')
disp('    (Press any key to continue...)')
pause

figure(fig+4),plot(Nm,[sum(y(1:3,1))/3 sum(y(1:3,2:nptos))],'bo'),hold on,plot(Nm,y(4,:),'k+')
xlabel('Digital Value')
ylabel('Luminance')
title('o Sum of Guns         + White Luminances');
hold off

coco1=chro_guns;
s=size(coco1);
Tmon1=coor2tri([[coco1(2:3,:)';coco1(4:5,:)';coco1(6:7,:)'] ones(3*s(2),1)],Msx(2,:));
Tmon2=newbasis(Tmon1,Msx);
tmon2=Tmon2./[sum(Tmon2')' sum(Tmon2')' sum(Tmon2')'];
tmon2=tmon2(:,1:2);
coco2(1:2,:)=[tmon2(1:s(2),:)]';
coco2(3:4,:)=[tmon2(s(2)+1:2*s(2),:)]';
coco2(5:6,:)=[tmon2(2*s(2)+1:3*s(2),:)]';
chro_guns=[coco1(1,:);coco2];

coco1=chro_whites;
s=size(coco1);
Tmon1=coor2tri([coco1(2:3,:)' ones(s(2),1)],Msx(2,:));
Tmon2=newbasis(Tmon1,Msx);
tmon2=Tmon2./[sum(Tmon2')' sum(Tmon2')' sum(Tmon2')'];
tmon2=tmon2(:,1:2);
coco2(1:2,:)=[tmon2(1:s(2),:)]';
%coco2(3:4,:)=[tmon2(s(2)+1:2*s(2),:)]';
%coco2(5:6,:)=[tmon2(2*s(2)+1:3*s(2),:)]';
chro_whites=[coco1(1,:);coco2];

eval(['save ',tray,' a g ea eg yr yg yb yw chro_guns chro_whites'])
