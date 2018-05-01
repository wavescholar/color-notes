 function saveillu(illu,tray)

% SAVEILLU save illuminants.
% 
% Illuminants are spectral-like variables defined with DEFILLU or 
% loaded with LOADILLU. 
% SAVEILLU normalizes the spectral radiance of the illuminant to
% give a relative distribution in the range [0 1].
% LOADILLU undoes this normalization to obtain the required luminance
% or radiance.
%  
% SYNTAX
% ----------------------------------------------------------------------
%
% saveillu(illum,['path']);
% 
% illum    = Illuminant
%  
% ['path'] = String containing the path to the file. For example: 
%            'c:/matlab/toolbox/colorlab/colordat/illumin/illum_CIE_A.mat' 
% 

iluminan=illu;
iluminan(:,2)=iluminan(:,2)/maxi(iluminan(:,2));
eval(['save ',tray,' iluminan']);