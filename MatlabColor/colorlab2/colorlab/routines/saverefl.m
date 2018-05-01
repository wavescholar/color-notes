function saverefl(rere,tray)

% SAVEREFL save reflectances/transmitances.
% 
% Reflectances (and transmitances) are spectral-like variables 
% defined with DEFREFL or loaded with LOADREFL. 
% SAVEILLU normalizes the spectral radiance of the illuminant to
% give a relative distribution in the range [0 1].
% LOADILLU undoes this normalization to obtain the required luminance
% or radiance.
% 
% SYNTAX
% ----------------------------------------------------------------------
% 
% saverefl(refl,['path']);
% 
% refl    = Reflectance (or Transmitance).
% 
% ['path'] = String containing the path to the file. For example: 
%            'c:/matlab/toolbox/colorlab/colordat/reflec/yellow_sample.mat' 
% 


reflec=rere;
save(tray,'reflec')
