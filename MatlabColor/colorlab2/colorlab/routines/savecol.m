function savecol(T,Msx,caracter,tray)

% SAVECOL saves a set of colors in COLORLAB format
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
% savecol(T,Msx,characteriz,'file')
% 
% T           = Specification of the N colors: the variable, T, N*3 color-like matrix.
%
% Msx         = Specification of the color system: the variable, Msx, 
%               3*3 change-of-basis matrix that relates the system with the CIEXYZ.
%               (This matrix is given in the definition of the system. See DEFSYS.M)
% 
% characteriz = Specification of the representation: the variable, caracter, describes
%               the nature of the representation used in T.
%               caracter = 1.....Tristimulus vectors   
%               caracter = 2.....Chromatic coordinates and luminance
%               caracter = 3.....Dominant wavelength, excitation purity and luminance
%               caracter = 4.....Dominant wavelength, colorimetric purity and luminance
%
% file        = String with the path to the desired *.mat file
%

eval(['save ',tray,' T Msx caracter']);