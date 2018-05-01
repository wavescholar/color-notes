function savemon(Msx,coco,a,g,tray);

% SAVEMON saves the monitor calibration data to a (manually) given file
% 
% The 'COLORLAB format for CRT calibration data storage' is just a name 
% convention for the variables involved in the CRT calibration. 
% Such a convention is covenient for future automatic transform of the data 
% to the required color system when using LOADMON.M
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
% SYNTAX
% ---------------------------------------------------------------------------------------
% 
% savemon(Msx,tm,a,g,'path')
% 
% Msx    = 3*3 change-of-basis matrix that relates the system S (where the data
%          are expressed in) to the CIEXYZ system.
% tm     = 7*N matrix that contains the chromaticities of the R, G and B guns for 
%          N calibration points of the digital value (see CALIBRAT.M for details).
%          The chromaticities are given in the system at hand eventhough they are 
%          stored in the CIEXYZ system (this is why Msx is needed). 
% a      = 1*3 vector including the constants a_i of the gamma relation for each gun.
% g      = 1*3 vector including the constants g_i of the gamma relation for each gun.
% 'path' = String with the path to the file containing the data. For example:
%          'c:\matlab\toolbox\colorlab\colordat\monitor\monito.mat'
% 
% REQUIRED FUNCTIONS
% ---------------------------------------------------------------------------------------
% coor2tri.m 
% newbasis.m 


% Data expressed in the system S
coco1=coco;  

% Change to the CIEXYZ system
s=size(coco1);
Tmon1=coor2tri([[coco1(2:3,:)';coco1(4:5,:)';coco1(6:7,:)'] ones(3*s(2),1)],Msx(2,:));
Tmon2=newbasis(Tmon1,Msx);
tmon2=Tmon2./[sum(Tmon2')' sum(Tmon2')' sum(Tmon2')'];
tmon2=tmon2(:,1:2);
coco2(1:2,:)=[tmon2(1:s(2),:)]';
coco2(3:4,:)=[tmon2(s(2)+1:2*s(2),:)]';
coco2(5:6,:)=[tmon2(2*s(2)+1:3*s(2),:)]';
coco2=[coco1(1,:);coco2];

% Data in the CIEXYZ system
chro_guns=coco2;   

% Now we can save the data
eval(['save ',tray,' chro_guns a g']);