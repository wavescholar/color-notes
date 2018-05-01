function Y=td2lum(td,form)

% TD2LUM computes the luminance Y (cd/m2) of a stimulus producing
% retinal illuminance I, in trolands (td):
%
%      I(td)=Y(cd/m2)*pupilar area (mm^2)
%
% Two computation methods are available. 
%
% SYNTAX
% ----------------------------------------------------------------------------
% Y=td2lum(I,form)
%
% I = Retinal illuminance.
%
% form = Parameter determining the expresion for computing the retinal
%        illuminance.
%        If form=1, the pupilar diameter is computed with as:
%                d=5-3*tanh(0.4log10(Y)) (Crawford)
%        If form=2, Guth's formula is used (Guth-1994):
%                I=18*Y^0.8
%
% Y = Luminance (cd/m2)
%
% Y=td2lum(I) uses form=2 by default,
%
% RELATED FUNCTIONS
% ----------------------------------------------------------------------------
% lum2td
%
%This function is used by XYZTD2L and INGUTH.

if nargin==1
   form=2;
end
num=length(td);
OPTIONS(14)=6000;
OPTIONS(1:3)=[0 1e-12 1e-12];
if form==1
   for i=1:num
    fun=['abs(pi*abs(x).*(((5-3*tanh(0.4*log10(abs(x))))/2).^2)-' num2str(td(i)) ')'];
    Y(i)=fmins(fun,td(i)/10,OPTIONS);
   end
   Y=abs(Y);
   Y=Y';
elseif form==2
   Y=(td/18).^(1/0.8);
end

