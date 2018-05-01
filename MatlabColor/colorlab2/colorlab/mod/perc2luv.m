function luv=perc2luv(perc)

% PERC2LAB computes the L*u*v* descriptors of a set of stimuli, from their 
% perceptual CIELUV descriptors.
%
% SYNTAX
% ----------------------------------------------------------------------------
% LUV=perc2luv(LhC)
%
% LhC = For N stimuli, Nx3 matrix. The first column contains the lightness L*,
%        the second the hue angle (h*=atan(u*/v*), 0<=h*<=2*pi) and the third
%        the chroma (C*=sqrt(u*^2+v*^2)).
%
% LUV = Ligthness and chromaticity coordinates of the stimuli in CIELUV.
%       For N stimuli, this is a Nx3 matrix.
%   
% RELATED FUNCTIONS
% ----------------------------------------------------------------------------
% luv2perc, xyz2luv, luv2xyz


luv=[perc(:,1) perc(:,3).*cos(perc(:,2)) perc(:,3).*sin(perc(:,2))];
