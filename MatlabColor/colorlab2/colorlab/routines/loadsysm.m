function [f_igual,utri,Msx]=loadsysm(tray)

% LOADSYSM load the data of a color basis from a (manually) given file
% 
% The data that defines a basis of the tristimulus space are:
% - Color matching functions
% - Trichromatic units
% - The matrix that relates this representation to the CIE XYZ representation
% 
% SYNTAX:
% -------------------------------------------------------------------------------
%
% [T_l,Yw,Mbx]=loadsysm(['path']);
%
% ['path'] = String with the path to a file with color basis data
%            For example, 'c:/matlab/toolbox/colorlab/colordat/systems/ciergb.mat'  
% 
% T_l      = Color matching functions (spectral-like, N*4 variable)
%
% Yw       = Trichromatic units (1*3 vector)
%
% Mbx      = The change-to-CIEXYZ matrix (3*3 matrix)
%

load(tray)

if any([exist('f_igual') exist('utri') exist('Msx')]~=1)
   f_igual=[];utri=[];Msx=[];
   disp(' ');
   disp(['  File ' tray ' does not contain a color basis']);
   disp('  in COLORLAB format. See SAVESYS.');
end