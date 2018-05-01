function [coco2,a,g]=loadmon(Msx)

% LOADMON opens a dialog box to load the calibration data of the monitor.
% 
% COLORLAB assumes additivity and independence between the guns of the CRT monitor.
% COLORLAB also assumes an exponential relation (gamma relation) between the luminance 
% of the gun, i, and the corresponding digital value, n_i (i=1,2,3). 
% COLORLAB makes no assumption on the chromaticities of the guns (that may depend on the 
% digital value in any complex way).
%
% With these assumptions, the calibration data include:
% - Chromaticities of the gun, i, as a function of the digital step, n_i.
% - Parameters (a_i and g_i) of the gamma relation between the luminance of 
%   the gun, i, and the digital, n_i:    Y_i=a_i*n_i^g_i 
% 
% LOADMON loads these data from a (generic) file provided with COLORLAB (as monito.mat)
% or from a specific file generated with CALIBRAT.M or SAVEMON.M for your particular 
% display. (see the help of CALIBRAT.M for the details on the calibration).
% 
% SYNTAX
% ---------------------------------------------------------------------------------------
% 
% [tm,a,g]=loadmon(Msx);
% 
% Msx = 3*3 change-of-basis matrix that relates the system at hand to the CIEXYZ system.
% tm  = 7*N matrix that contains the chromaticities of the R, G and B guns for 
%       N calibration points of the digital value (see CALIBRAT.M for details).
%       The chromaticities are given in the system at hand eventhough they are stored 
%       in the CIEXYZ system (this is why Msx is needed). 
% a   = 1*3 vector including the constants a_i of the gamma relation for each gun.
% g   = 1*3 vector including the constants g_i of the gamma relation for each gun.
%
% REQUIRED FUNCTIONS
% ---------------------------------------------------------------------------------------
% coor2tri.m
% newbasis.m

p=which('std_crt.mat');
pp=fileparts(p);
cd(pp)

[fich,tray]=uigetfile('*.*','Load monitor data');
fichero=fullfile(tray,fich);
load(fichero)

if exist('chro_guns') & exist('a') & exist('g')
 coco1=chro_guns;
 s=size(coco1);
 Tmon1=coor2tri([[coco1(2:3,:)';coco1(4:5,:)';coco1(6:7,:)'] ones(3*s(2),1)],[0 1 0]);
 Tmon2=newbasis(Tmon1,inv(Msx));
 tmon2=Tmon2./[sum(Tmon2')' sum(Tmon2')' sum(Tmon2')'];
 tmon2=tmon2(:,1:2);
 coco2(1:2,:)=[tmon2(1:s(2),:)]';
 coco2(3:4,:)=[tmon2(s(2)+1:2*s(2),:)]';
 coco2(5:6,:)=[tmon2(2*s(2)+1:3*s(2),:)]';
 coco2=[coco1(1,:);coco2];
else
 disp(' ');
 disp(['  File ' tray fich ' does not contain monitor data']);
 disp('  in COLORLAB format. See SAVEMON.');
 coco2=[];a=[];g=[];
end