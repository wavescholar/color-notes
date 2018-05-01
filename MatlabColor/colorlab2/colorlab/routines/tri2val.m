function [n2,satur,Tpos]=tri2val(T,utri,coco,a,g,res,ntime)

%  TRI2VAL computes digital values, n, from tristimulus vectors, T.
%  
%  Computers do not use an appropriate (colorimetrically meaningful)
%  description of color, but 3D arrays of parameters n=[n1 n2 n3]
%  that control the voltages of each gun of the CRT. 
%  In most standard image formats these 'ni' values (digital values) 
%  are given using 8 bit integers (uint8 variables ranging from 0 to 255).
%  This is a device-dependent characterization because the color 
%  obtained from a given array, n, depends on the particular color 
%  reproduction device.
%  
%  In MATLAB colormaps the digital values that describe the colors are 
%  real numbers with values in [0,1] (ranging from minimum luminance to 
%  maximum luminance of the gun).
%  
%  TRI2VAL computes this (meaningless) device-dependent color characterization,
%  n, from the (colorimetrically meaningful) characterization using tristimulus 
%  vectors, T.
% 
%  In this way you will be able to generate MATLAB colormaps (and represent 
%  color images or save them in standard formats) from the corresponding 
%  tristimulus characterization.
% 
%  To do so, the CRT calibration (see CALIBRAT.M) has to be taken into account.
%  
%  The limitations of the color reproduction device (the CRT) imply certain 
%  restrictions on the gamut of colors that can be represented using the
%  representation with digital values. 
%  Remember that ni is restricted to be in the range [0,1], so luminance is
%  limited and certain (highly saturated) chromaticities are not available.
%  Also remember that the VGA has a limited (8 bit) resolution, so very close
%  ni give rise to the same output luminance.
%  This implies that only a discrete set (grid) of colors inside a limited 
%  gamut is available.
%  As a result, not every real color, T, can be represented by n.
%  In general a certain (quantization or gamut limitation) error is make 
%  when using the digital value representation.
%  Therefore, the nearest available color, Tn, corresponding to the array, n, 
%  will be different from the desired color, T.
%
%  TRI2VAL computes the array, n, that minimizes the error T-Tn in the 
%  tristimulus space you are working in.
%  TRI2VAL looks for the best array, n, taking into account the resolution 
%  (in bits/channel) of the VGA at hand. 
% 
%  SYNTAX
%  -------------------------------------------------------------------------------
% 
%  [n,saturat,Tn]=tri2val(T,Yw,tm,a,g,res);
%  [n,saturat,Tn]=tri2val(T,Yw,tm,a,g,res,wtbar);
%
%  INPUT Variables
%  
%  T   = Input color-like variable (N*3 variable) with N colors (tristimulus vectors).
%  
%  Yw  = Trichromatic units
%  
%  tm  = 7*M matrix that contains the chromaticities of the R, G and B guns for 
%        M calibration points of the digital value (see CALIBRAT.M).
%  
%  a   = 1*3 vector including the constants a_i of the gamma relation for each gun.
%        (see CALIBRAT.M)
%  
%  g   = 1*3 vector including the constants g_i of the gamma relation for each gun.
%        (see CALIBRAT.M)
%  
%  res = resolution (in bits/channel) of the VGA. (8 bits in the standard VGAs)
%
%
%  OUTPUT Variables
%  
%  n       = Output color-like variable (N*3 variable) with N colors (digital values).
%            This is a colormap ready to use in the MATLAB environment.
%  
%  saturat = Colors with high luminance may lie outside the gamut of available colors.
%            If this is the case, TRI2VAL reduces their luminance until they do not 
%            saturate any digital value.
%            The variable 'saturat' is a N*1 variable that indicates the colors that
%            have been reduced in luminance because of this saturation.
%            Zero in this variable indicates that the luminance of the corresponding
%            color hasnt been modified. 
%            On the contrary, one indicates that the luminance of the corresponding
%            color has been modified.
%  
%  Tn      = Color-like N*3 variable with the tristimulus values corresponding to the 
%            colors in the colormap n. 
%            The colors in Tn are the nearest colors to T available using the discrete
%            device-dependent representation.
%
%  wtbar   = If wtbar==1, a waitbar is displayed to monitor the progress of the computations.
%            If wtbar==0, no waitbar is displayed.
%            By default, wtbar=1;
%
%  
%  
%  REQUIRED FUNCTIONS
%  ---------------------------------------------------------------------------------
%      t2n.m    miniecol.m         n2t.m
%  tri2lum.m      errcol.m    ganadora.m
%  lum2niv.m    niv2coor.m
%

%  
%  Los valores triestimulo se introducen en el sistema de primarios Pi en el que se expresen las 
%  coordenadas cromaticas de los primarios del monitor (en la practica sera el sistema CIE XYZ 
%  porque lo mas seguro es que las coordenadas se hayan medido con el Topcon, que da las x y). 
%  Hemos de introducir las unidades tricromaticas del sistema de primarios empleado (en el caso 
%  del CIE XYZ seran [0 1 0]). 
%  

if nargin==6;
   ntime=1;
end
cococo=coco(2:7,end)';
l=size(T);
l=l(1);
satur=zeros(l,1);
lcoco=size(coco);
Nmax=coco(1,lcoco(2));
lado=1/(2^res);

if ntime==1
   h=waitbar(0,'Computing digital levels from tristimulus vectors...');
end
for i=1:l
    if ntime==1;waitbar(i/l);end
    coor(1,:)=cococo(1,1:2);
    coor(2,:)=cococo(1,3:4);
    coor(3,:)=cococo(1,5:6);
    k=0;
    TT=T(i,:);
    inc=TT/100;
    while k<1
       niv0=t2n(TT,a,g,coor,utri);
       niv0=niv0.*(+(niv0>0));
       if any(niv0>Nmax)
          TT=TT-inc;
          satur(i,:)=1;
       else
          k=1;
       end       
    end
    [niv,e]=miniecol(niv0,TT,lado,a,g,coco,utri);
    n2(i,:)=niv;
    % n1(i,:)=round(niv);
    coor=niv2coor(n2(i,:),coco);
    Tpos(i,:)=n2t(n2(i,:),a,g,coor,utri);
end
if ntime==1;close(h);end