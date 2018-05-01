function xyzn=xyz2xyzn(xyz,modelo);

% XYZ2XYZN normalizes tristimulus values with the criterion specified in the
% specified colour vision model.
%
% SYNTAX
% ----------------------------------------------------------------------------
% XYZN=xyz2xyzn(XYZ,model)
%
% XYZ = Input tristimulus values. Nx3 matrix for N colours.
%
% model = Integer (1-13) identifying the model. See XYZ2ATD for details.
%
% XYZN = Normalized tristimulus values. Same size than XYZ.
%
% REQUIRED FUNCTIONS
% ----------------------------------------------------------------------------
% cambial xyzl2td
%
% RELATED FUNCTIONS
% ----------------------------------------------------------------------------
% xyzn2xyz
%
%This function is used by XYZ2CON and CON2XYZ.

num=size(xyz);
if modelo<=7 | modelo==12
   xyzn=xyz;
elseif modelo==8
 for i=1:num(1)
   if xyz(i,2)<=0
     xyzn(i,:)=[0 0 0];
   else
     xyzn(i,:)=cambial(xyz(i,:),xyz(i,2),8,0);  
   end
 end
elseif modelo>=9 & modelo<12
 for i=1:num(1)
   if xyz(i,2)<=0
      xyzn(i,:)=[0 0 0];
   else
      xyzn(i,:)=xyzl2td(xyz(i,:));
   end
 end
end
