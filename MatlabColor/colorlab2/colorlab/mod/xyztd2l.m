function xyzl=xyztd2l(xyzt,form)

% XYZTD2L re-normalizes tristimulus values with Y equal the retinal illuminance,
% to make Y equal to the luminance. 
%
% SYNTAX
% ----------------------------------------------------------------------------
% XYZL=xyztd2l(XYZTD,form)
%
% XYZTD = Tristimulus values with Y=retinal illuminance.
%         For N stimuli, this is a Nx3 matrix.
%
% form = Parameter determining the expresion for computing the retinal
%        illuminance.
%        If form=1, the pupilar diameter is computed with as:
%                d=5-3*tanh(0.4log10(Y)) (Crawford)
%        If form=2, Guth's formula is used (Guth-1994):
%                I=18*Y^0.8
%
% XYZL = Tristimulus values with Y=luminance (cd/m2).
%        For N stimuli, this is a Nx3 matrix.
% 
% With XYZL=xyztd2l(XYZTD), Guth's formula is used. 
%
% REQUIRED FUNCTIONS
% ----------------------------------------------------------------------------
% td2lum.
%
% RELATED FUNCTIONS
% ----------------------------------------------------------------------------
% xyzl2td
%
%This function is used by XYZN2XYZ

if nargin==1
   form=2;
end
num=size(xyzt);
lum=td2lum(xyzt(:,2),form);
warning off
xyzl=xyzt.*((lum./(xyzt(:,2))*ones(1,num(2))));
novale=find(xyzt(:,2)==0);
xyzl(novale,:)=zeros(length(novale),3);
warning on


