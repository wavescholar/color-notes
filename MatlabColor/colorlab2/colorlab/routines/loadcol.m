function [T]=loadcol(f_igual,utri,Mfx,carac,tray)

% LOADCOL loads a set of colors in COLORLAB format
% 
% LOADCOL return the colors in the appropriate color
% space and in the desired representation.
% 
% The meaning of a given color characterization depends 
% on its nature -for instance, T versus (t,Y)- and on the 
% color space where the color was defined -for instance
% CIERGB versus NTSCRGB-.
% 
% The COLORLAB format for color storage includes the 
% necessary additional information to ensure an appropriate
% retrieval from any other tristimulus space and required 
% representation.
%
% A COLORLAB color file consists of three variables:
% - T, a N*3 color-like matrix that specifies the N colors: .
% - Msx, a 3*3 change-of-basis matrix that specifies the color space 
%   where T is defined. It relates the system with the CIEXYZ system. 
% - caracter, a parameter that specifies the representation used in T.
% 
% SYNTAX
% ---------------------------------------------------------------------------------------
% 
% T=loadcol(T_l,Yw,Msx,caracter,'file');
% 
% T_l         = Specification of the current color system (the color system where we 
%               want the output). Color matching functions.
%
% Yw          = Specification of the current color system (the color system where we 
%               want the output). Trichromatic units.
%
% Msx         = Specification of the current color system (the color system where we 
%               want the output): 
%               the variable, Msx, is a 3*3 change-of-basis matrix that relates the 
%               system with the CIEXYZ.
% 
% characteriz = Specification of the representation we want for the output: 
%               caracter = 1.....Tristimulus vectors   
%               caracter = 2.....Chromatic coordinates and luminance
%               caracter = 3.....Dominant wavelength, excitation purity and luminance
%               caracter = 4.....Dominant wavelength, colorimetric purity and luminance
%
% file        = String with the path to the *.mat file we want to load
%
% T           = Output specification of the N colors in the desired space and 
%               representation: N*3 color-like matrix.
%
% REQUIRED FUNCTIONS
% ---------------------------------------------------------------------------------------
% newbasis.m
% coor2tri.m
% lp2coor.m
% tri2coor.m
% coor2lp.m
% 

load(tray)

if exist('T')
 if caracter==1
    T=newbasis(T,inv(Mfx)*Msx);
 elseif caracter==2
    T=coor2tri(T,Msx(2,:));
    T=newbasis(T,inv(Mfx)*Msx);
 else
    f_igual2=newbasis(f_igual(:,2:4),inv(Msx)*Mfx);
    f_igual2=[f_igual(:,1) f_igual2]; 
    T=lp2coor(T,floor(caracter/2),f_igual2,Msx(2,:));
    T=coor2tri(T,Msx(2,:));
    T=newbasis(T,inv(Mfx)*Msx);
 end
 
 if carac==2
    T=tri2coor(T,utri);
 elseif carac>2
    T=tri2coor(T,utri);
    T=coor2lp(T,floor(carac/2),f_igual,utri);
 end
else
   disp([' ']);
   disp([' WARNING: File ' tray ' does not contain a set of colours in COLORLAB format.']);
   disp('  See SAVECOL.');
   T=[];
end