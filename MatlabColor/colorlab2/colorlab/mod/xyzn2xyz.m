function xyz=xyzn2xyz(xyzn,modelo);

% XYZN2XYZ undoes the normalization performed by XYZ2XYZN.
%
% SYNTAX
% ----------------------------------------------------------------------------
% XYZ=xyzn2xyz(XYZN,model)
%
% XYZN = Normalized tristimulus values. Same size than XYZ.
%
% model = Integer (1-13) identifying the model. See XYZ2ATD for details.
%
% XYZ = Input tristimulus values. Nx3 matrix for N colours.
%
% REQUIRED FUNCTIONS
% ----------------------------------------------------------------------------
% cambial xyztd2l
%
% RELATED FUNCTIONS
% ----------------------------------------------------------------------------
% xyz2xyzn
%
%This function is used by CON2XYZ

num=size(xyzn);
if modelo<=7 | modelo==12
   xyz=xyzn;
elseif modelo==8
  for i=1:num(1)
   if xyzn(i,2)<=0
      xyz(i,:)=[0 0 0];
   else  
      xyz(i,:)=cambial(xyzn(i,:),xyzn(i,2),modelo,1);  
   end
  end
elseif modelo>=9 & modelo<12
  for i=1:num(1)
   if xyzn(i,2)<=0
      xyz(i,:)=[0 0 0];
   else
      xyz(i,:)=xyztd2l(xyzn(i,:));
   end
  end
end
