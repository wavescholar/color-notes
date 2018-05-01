function savesysm(f_igual,utri,Msx,tray)

% SAVESYSM saves the data of a color basis to a (manually) given file.
% 
% The data that defines a color basis are:
% - Color matching functions
% - Trichromatic units
% - The matrix that relates this representation to the CIE XYZ representation
% 
% SYNTAX:
% -------------------------------------------------------------------------------
%
% savesysm(T_l,Yw,Mbx,'path');
% 
% T_l    = Color matching functions (spectral-like, N*4 variable)
%
% Yw     = Trichromatic units (1*3 vector)
%
% Mbx    = The change-to-CIEXYZ matrix (3*3 matrix)
%
% 'path' = String with the path to a file with color basis data
%          For example, 'c:/matlab/toolbox/colorlab/colordat/systems/ciergb.mat'  
%


eval(['save ',tray,' f_igual utri Msx']);