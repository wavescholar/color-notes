function d=distsvf(XYZ1,XYZ2,XYZW);

% DIFSVF computes the colour difference in the SVF space of two stimuli,
% under the specified illumination conditions.
% The definition of distance used weights differently the
% achromatic and chromatic contributions:
%
%     D(C1,C2) = sqrt( 2.3*AV^2 + AF1^2 + AF2^2 )
%
% SYNTAX
% ----------------------------------------------------------------------------
% D=DIFSVF(XYZ1,XYZ2,XYZW)
%
% XYZ1, XYZ2 = Tristimulus CIE-1931 values of the two set of stimuli whose
%              colour differences we want to compute.
%              Both parameters are Nx3 matrixes, with N=number of colours.
% XYZW       = Tristimulus CIE-1931 values of the reference white.
%
% D          = Colour difference (Nx1 matrix).
%
% REQUIRED FUNCTIONS
% ----------------------------------------------------------------------------
% XYZ2SVF
%
% RELATED FUNCTIONS
% ----------------------------------------------------------------------------
% XYZ2SVF, SVF2XYZ


format short;
e=xyz2svf(XYZ1,XYZW);
s=xyz2svf(XYZ2,XYZW);
d=e-s;

d=sqrt(2.3*d(:,1).^2+sum([d(:,2:3).^2]')');