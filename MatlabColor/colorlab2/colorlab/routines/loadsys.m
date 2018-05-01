function [f_igual,utri,Msx]=loadsys()

% LOADSYS  load the data of a color basis using a dialog box
% 
% The data that defines a basis of the tristimulus space are:
% - Color matching functions
% - Trichromatic units
% - The matrix that relates this representation to the CIE XYZ representation
% 
% SYNTAX:
% -------------------------------------------------------------------------------
%
% [T_l,Yw,Mbx]=loadsys;
% 
% T_l = Color matching functions (spectral-like, N*4 variable)
%
% Yw  = Trichromatic units (1*3 vector)
%
% Mbx = The change-to-CIEXYZ matrix (3*3 matrix)
%

p=which('ciergb.mat');
pp=fileparts(p);
cd(pp)

[fich,tray]=uigetfile('*.*','Load system data');
fichero=fullfile(tray,fich);
load(fichero)

if any([exist('f_igual') exist('utri') exist('Msx')]~=1)
   f_igual=[];utri=[];Msx=[];
   disp(' ');
   disp(['  File ' tray fich ' does not contain a color basis']);
   disp('  in COLORLAB format. See SAVESYS.');
end