function I=lum2td(Y,form)

% LUM2TD computes the retinal illuminance, I, in trolands (td) 
% of a stimulus with luminance Y (cd/m2):
%
%      I(td)=Y(cd/m2)*pupilar area (mm^2)
%
% Two computation methods are available. 
%
% SYNTAX
% ----------------------------------------------------------------------------
% I=lum2td(Y,form)
%
% Y = Luminance (cd/m2)
%
% form = Parameter determining the expresion for computing the retinal
%        illuminance.
%        If form=1, the pupilar diameter is computed with as:
%                d=5-3*tanh(0.4log10(Y)) (Crawford)
%        If form=2, Guth's formula is used (Guth-1994):
%                I=18*Y^0.8
% I = Retinal illuminance.
%
% I=lum2td(Y) uses form=2 by default.
%
% RELATED FUNCTIONS
% ----------------------------------------------------------------------------
% td2lum
%
%This function is used by XYZL2TD and NGUTH.

if nargin==1
   form=2;
end
if form==1
   d=5-3*tanh(0.4*log10(Y));
   I=Y.*(pi*(d/2).^2);
elseif form==2
   I=18*(Y.^0.8);
end
