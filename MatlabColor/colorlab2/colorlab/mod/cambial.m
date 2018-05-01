function XYZf=cambial(XYZ,lum,modelo,inv)

% CAMBIAL scales or undoes the scaling of tristimulus values of a set of stimuli
% with the criteria of the a given model. 
%
% SYNTAX
% ----------------------------------------------------------------------------
% XYZF=CAMBIAL(XYZ,Y0,MODEL,INV)
% 
% XYZ = Tristimulus values to re-scale.
%       For N stimuli, this is a Nx3 matrix.
%
% Y0  = Value to which the Y must be re-scaled.
%       Y0 is a number.
%
% MODEL = Integer (1-13) specifying the model. See XYZ2ATD.
%
% INV = If this parameter is zero, the XYZ, with Y equal to the luminance, is
%       re-scaled with the criterion of the model. 
%       If INV=1, the scaling of the model is removed and Y becomes again equal
%       to the luminance.
%
% XYZF = Tristimulus values re-scaled for Y to equal Y0.
%
% REQUIRED FUNCTIONS
% ----------------------------------------------------------------------------
% NGUTH LUM2TD	INGUTH TD2LUM
%
%Function used by XYZ2XYZN and XYZN2XYZ.


cuantos=size(XYZ);
if (lum>0)
	if modelo==8
		if inv==0
			L=nguth90(lum);
		elseif inv==1
		        L=inguth90(lum);
		end
	else L=lum;
	end
else L=0;
end
XYZ(:,2)=(+(XYZ(:,2)>0)).*XYZ(:,2)+(XYZ(:,2)==0);

for i=1:3
	factor(:,i)=L./XYZ(:,2);
end
XYZf=XYZ.*factor;

