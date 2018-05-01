function xyzt=xyzl2td(xyzl,form)

% XYZL2TD normalizes the tristimulus values XYZ, with Y equal to the luminance,
% to make Y equal to the retinal illumination. 
%
% SYNTAX
% ----------------------------------------------------------------------------
% XYZT=xyzl2td(XYZL,FORM)
%
% XYZL = Tristimulus values with Y=luminance (cd/m2).
%        For N stimuli, this is a Nx3 matrix.
%
% form = Parameter determining the expresion for computing the retinal
%        illuminance.
%        If form=1, the pupilar diameter is computed with as:
%                d=5-3*tanh(0.4log10(Y)) (Crawford)
%        If form=2, Guth's formula is used (Guth-1994):
%                I=18*Y^0.8
%
% XYZTD = Tristimulus values with Y=retinal illuminance.
%         For N stimuli, this is a Nx3 matrix.
%
% With XYZT=xyzl2td(XYZTL), Guth's formula is used. 
%
% REQUIRED FUNCTIONS
% ----------------------------------------------------------------------------
% lum2td
%
% RELATED FUNCTIONS
% ----------------------------------------------------------------------------
% xyztd2l
%
%This function is used by XYZN2XYZ


if nargin==1
   form=2;
end
num=size(xyzl);
lum=lum2td(xyzl(:,2),form);
warning off
xyzt=xyzl.*((lum./(xyzl(:,2))*ones(1,num(2))));
novale=find(xyzl(:,2)==0);
xyzt(novale,:)=zeros(length(novale),3);
warning on


