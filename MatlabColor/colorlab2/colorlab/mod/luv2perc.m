function perc=luv2perc(luv)

% LUV2PERC computes the lightness, chroma and hue angle of a set of colours 
% characterized in the CIELUV space.
%
% SYNTAX
% ----------------------------------------------------------------------------
% LhC=LUV2PERC(LUV)
%
% LUV = Ligthness and chromaticity coordinates of the stimuli in CIELUV.
%       For N stimuli, this is a Nx3 matrix.
%
% LhC = For N stimuli, Nx3 matrix. The first column contains the lightness L*,
%        the second the hue angle (h*=atan(v*/u*), 0<=h*<=2*pi) and the third
%        the chroma (C*=sqrt(u*^2+v*^2)).
%        
% RELATED FUNCTIONS
% ----------------------------------------------------------------------------
% PERC2LUV, XYZ2LUV, LUV2XYZ


perc=[luv(:,1) atan2(luv(:,3),luv(:,2))+2*pi*(+(atan2(luv(:,3),luv(:,2))<0)) sqrt((luv(:,3).^2)+(luv(:,2).^2))];

