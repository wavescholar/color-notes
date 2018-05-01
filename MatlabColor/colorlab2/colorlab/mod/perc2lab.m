function lab=perc2lab(perc)

% PERC2LAB computes the L*a*b* descriptors of a set of stimuli, from their 
% perceptual CIELAB descriptors.
%
% SYNTAX
% ----------------------------------------------------------------------------
% LAB=perc2lab(LhC)
%
% LhC = For N stimuli, Nx3 matrix. The first column contains the lightness L*,
%        the second the hue angle (h*=atan(b*/a*), 0<=h*<=2*pi) and the third
%        the chroma (C*=sqrt(a*^2+b*^2)).
%
% LAB = Ligthness and chromaticity coordinates of the stimuli in CIELAB.
%       For N stimuli, this is a Nx3 matrix.
%   
% RELATED FUNCTIONS
% ----------------------------------------------------------------------------
% lab2perc, xyz2lab, lab2xyz


lab=[perc(:,1) perc(:,3).*cos(perc(:,2)) perc(:,3).*sin(perc(:,2))];
