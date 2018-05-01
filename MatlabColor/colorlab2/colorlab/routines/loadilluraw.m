function [iluminan]=loadillu(paso);

% LOADILLURAW load illuminants using a dialog box
% 
% LOADILLURAW opens a dialog box where the user can select 
% the file to load the illuminant from. 
% This file should have been created by SAVEILLU or contain a 
% spectral-like variable named ILUMINAN. 
% The relative spectrum in the file is scaled to give the 
% desired luminance or radiance. 
%
% LOADILLURAW returns a spectral-like variable (wavelength-magnitude)
% with the relative power of the illuminat
% Optionally, you can select the sampling resolution of the wavelength
% domain.
% 
% SYNTAX:   
% --------------------------------------------------------------
%
% esp=loadilluraw(D_lambda);
%
%  D_lambda = wavelength step (in nm) to sample the spectrum.
%  

if nargin==0
   interpolar=0;
else
   interpolar=1;
end
p=which('iluminan.d65');
pp=fileparts(p);
cd(pp)

[fich,tray]=uigetfile('*.*','Load Illuminant');
fichero=fullfile(tray,fich);
load(fichero)

if exist('ILUMINAN')
   iluminan=ILUMINAN;
elseif exist('Iluminan')
   iluminan=Iluminan;
end
if exist('iluminan')
 s=size(iluminan);
 l=max(s);
 if s(1)<s(2)
   iluminan=iluminan';
 end
 xmr=mini(iluminan(:,1));
 xMr=maxi(iluminan(:,1));
 if interpolar==1
   xx=xmr:paso:xMr; 
   iluminan=[xx' interp1(iluminan(:,1),iluminan(:,2),xx')];
 end

else
 disp(' ');
 disp(['  File ' tray fich ' does not contain an illuminant']);
 disp('  in COLORLAB format. See SAVEILLU.');
 iluminan=[];
end