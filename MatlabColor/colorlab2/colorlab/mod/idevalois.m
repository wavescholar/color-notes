function  XYZ=idevalois(ATD,v)

% IDEVALOIS computes the triestimulus values from the second opponent stage responses
% of the model by De Valois and Devalois (1993).
%
% USE: XYZ=idevalois(ATD,v)
%
%      ATD    = Second opponent-stage descriptors.
%      v      = Version (1=continuous, 2=discrete)
%      XYZ    = Tristimulus values of the problem colours.
%
% The first stage of this model is not inversible.
% 
% RELATED FUNCTIONS: devalois, xyz2atd, atd2xyz
%

if v==1
   LMS=(inv([9 4 1;90  -115    25;-130    95    35])*ATD')';
   %LMS=(inv([9 4 1;100  -110    10;-145    87.5    57.7])*ATD')';
else
   LMS=(inv([9 4 1;90 -115 30;-130 95 30])*ATD')';
   %LMS=(inv([9 4 1;100 -110 15;-145 87 52])*ATD')';
end
XYZ=con2xyz(LMS,7);
