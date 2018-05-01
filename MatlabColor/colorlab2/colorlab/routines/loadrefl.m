function [reflec]=loadrefl()

% LOADREFL load a reflectance/transmitance using dialog box
%
% LOADREFL opens a dialog box where the user can choose a file to
% load the reflectance/transmitance from.
% LOADREFL returns a spectral-like variable (wavelength-magnitude).
%  
% SYNTAX
% ----------------------------------------------------------------
%
% reflec=loadrefl;
%
% NOTE (on the Munsell reflectance database)
% ----------------------------------------------------------------
%
% COLORLAB comes with a database of reflectances corresponding to the 
% color samples of the Munsell Book of Color.
% In this book the samples are classified according to Hue, Chroma 
% and Value (Brightness).
% The notation used in the files is as follows:
%
%   * The files are organized in hue-named folders:
%
%               r,  yr,  y,  gy,  g,  bg,  b,  pb,  p,  rp    
%
%   * Inside each folder, the name of the files is made of 8 numbers:
%     
%                               HHHHVVCC  
%     
%     The first 4 numbers (HHHH) mean HUE. They may have values in the 
%     range HHHH=0000..0250....0500....1000. 
%     Going from 0000 to 1000 means fine change from one coarse hue to 
%     the next one (for example from 'green' -g- to green-blueish -bg-).
%
%     The next 2 numbers (VV) mean VALUE. They may have values in the 
%     range VV= 00, 10, 20, 30, 40, ...,90.
%
%     The last 2 numbers (CC) mean CHROMA. They may have values in 
%     the range CC= 00, 01, 02 ... 16.

p=which('munsell.mat');
pp=fileparts(p);
cd(pp)

[fich,tray]=uigetfile('*.*','Load Reflectance');
fichero=fullfile(tray,fich);
load(fichero)

if exist('reflec')~=1
   reflec=[];
   disp(' ');
   disp(['  File ' tray fich ' does not contain a spectral reflectance']);
   disp('  in COLORLAB format. See SAVEREFL.');
%else
%   m=size(reflec);
%   if m(2)~=1
%    disp(' ');
%    disp(['  File ' tray fich ' does not contain a spectral reflectance']);
%    disp('  in COLORLAB format. Reflectances must be Nx2 matrixes.');
%   end
end