function [iluminan]=loadilum(tray,Y,tipo,paso,f_igual,utri)


% LOADILUM load illuminant from a (manually) given file.
% 
% This file should have been created by SAVEILLU or contain a 
% spectral-like variable named ILUMINAN. 
% The relative spectrum in the file is scaled to give the 
% desired luminance or radiance. 
%
% LOADILUM returns a spectral-like variable (wavelength-magnitude)
% in nm and W/str*m2 respectively.
% The wavelength domain will be given by the limits of the color 
% matching functions at hand.
% You can select the sampling resolution of the wavelength domain.
% 
% SYNTAX:   
% --------------------------------------------------------------
%
% esp=loadilum('path',Y,opt,D_lambda,T_l,Yw);
%
% 'path'    = String containing the path to the file with the illuminant.
%             Example: 'c:/matlab/toolbox/colorlab/colordat/illumin/iluminan.a' 
%
%  Y        = Luminance (in cd/m2) or radiance (in W/str*m2) 
%             The meaning of Y (lum or rad) depends on the value
%             of 'opt'.
%
%  opt      = Selects the meaning of Y.
%             If opt==1, Y means luminance, else, Y means radiance.
%     
%  D_lambda = wavelength step (in nm) to sample the spectrum.
%  
%  T_l      = color matching functions.
%
%  Yw       = trichromatic units (in cd/m2).
%  

V=[f_igual(:,1) utri(1)*f_igual(:,2)+utri(2)*f_igual(:,3)+utri(3)*f_igual(:,4)];
xm=mini(V(:,1));
xM=maxi(V(:,1));

xx=xm:paso:xM;

VV=interp1(V(:,1),V(:,2),xx','linear');

load(tray)

if exist('ILUMINAN')
   iluminan=ILUMINAN;
elseif exist('Iluminan')
   iluminan=Iluminan;
end

if exist('iluminan');
 s=size(iluminan);
 l=max(s);
 if s(1)<s(2)
    iluminan=iluminan';
 end
 xmr=mini(iluminan(:,1));
 xMr=maxi(iluminan(:,1));
 
 if (xmr>xm)&(xMr<xM)
    iluminan=[xx' interp1([xm;iluminan(:,1);xM],[iluminan(1,2);iluminan(:,2);iluminan(l,2)],xx')];
 elseif (xmr==xm)&(xMr==xM)
    iluminan=[xx' interp1(iluminan(:,1),iluminan(:,2),xx')];
 elseif (xmr>xm)&(xMr>=xM)
    re=[xx' interp1([xm;iluminan(:,1)],[iluminan(1,2);iluminan(:,2)],xx')];
    iluminan=re; 
 elseif (xmr==xm)&(xMr>=xM)
    re=[xx' interp1(iluminan(:,1),iluminan(:,2),xx')];
    iluminan=re;
 elseif (xmr<=xm)&(xMr<xM)
    re=[xx' interp1([iluminan(:,1);xM],[iluminan(:,2);iluminan(l,2)],xx')];
    iluminan=re; 
 elseif (xmr<=xm)&(xMr==xM)
    re=[xx' interp1(iluminan(:,1),iluminan(:,2),xx')];
    iluminan=re;
 else
    re=[xx' interp1(iluminan(:,1),iluminan(:,2),xx')];
    iluminan=re;
 end
 
 if tipo==1
    Yi=683*(iluminan(:,2)'*VV*paso);
 else
    Yi=sum(iluminan(:,2)*paso);
 end 
 fac=Y/Yi;
 iluminan(:,2)=fac*iluminan(:,2);
else
 disp(' ');
 disp(['  File ' tray ' does not contain an illuminant']);
 disp('   in COLORLAB format. See SAVEILLU.');
 iluminan=[];
end