function tY=defcolor(f_igual,Yw,coord)

% DEFCOLOR graphic definition of colors
%
% DEFCOLOR opens a window where the user selects the chromaticity 
% of an arbitrary number of colors.
% Then, the user is prompted to introduce a luminance value for each 
% selected chromaticity.
%
% DEFCOLOR returns the colors expressed in chromatic coordinates and luminance 
% 
% SYNTAX
% ---------------------------------------------------------------------------------------
%   
%  t=defcolor(T_l,Yw,tm);
%
%  T_l        = Color Matching Functions in the current basis (N*4 spectral-like matrix).
%
%  Yw         = Trichromatic units (1*3 matrix)
%
%  tm         = Chromaticities of the monitor. 7*N matrix with the calibration data.
%               (see CALIBRAT.M or LOADMON.M).
%
%  t          = N*3 matrix (color-like variable) containing the chromaticities and
%               luminances of the selected colors.
%
% REQUIRED FUNCTIONS
% ---------------------------------------------------------------------------------------
% defcroma.m
% colordgm.m
% colord_c.m
% tri2coor.m
% lp2coor.m
% replocus.m, mini.m, maxi.m, niv2coor.m, ganadora.m
% 

% USO: [ti(C) Y(C)]=defcolor(Y,f_igual,coord_monit,simonum,fig,color?);
%

t=defcroma(f_igual,coord);

nc=size(t);
for i=1:nc(1)
    disp(' ')
    disp(' ')
    Y = input([' Luminance of color ',num2str(i),'?  (in cd/m2)  ']);
    disp(' ')
    disp(' ')
    tY(i,:)=[t(i,:) Y];
end 

