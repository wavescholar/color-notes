function  [ATD,LoMoSo]=devalois(XYZ,v,con,op1,op2)

% DEVALOIS computes the responses of the first and second opponent stages of the 
% model by De Valois and Devalois (1993) to stimuli described in the CEIXYZ space.
%
% USE: [ATD,LoMoSo]=devalois(XYZ,v)
%
%      XYZ    = Tristimulus values of the problem colours.
%      v      = Version (1=continuous, 2=discrete)
%      LoMoSo = First opponent-stage descriptors
%      ATD    = Second opponent-stage descriptors.
%
% [ATD,LoMoSo]=DEVALOIS(XYZ,v,CON,OP1,OP2)can be used to simulate the responses of
% of a colour defective or colour anomalous subject.
%
%      CON   = 3x3 matrix transforming the normal cones into anormal ones.
%      OP1   = 1x3 vector. Each component multiplies one of the first opponent stage 
%              responses.
%      OP2   = 1x3 vector. Each component multiplies one of the second opponent stage 
%              responses.
%
% RELATED FUNCTIONS: idevalois, xyz2atd, atd2xyz
%

if nargin<5
   op2=ones(1,3);
end
if nargin<4
   op1=ones(1,3);
end
if nargin<3
   con=eye(3);
end

LMS=xyz2con(XYZ,7);
LMS=(con*LMS')';
LoMoSo=([6 -5 -1*(+(v==1));-10 11 -1*(+(v==1));-10 -5 15]*LMS')';
LoMoSo=(diag(op1)*LoMoSo')'; 
TD=([10 -5 2;-10 +5 +2]*LoMoSo')';
%TD=([10 -5 1;-10 +5 3.5]*LoMoSo')';

A=([9 4 1]*LMS')';
ATD=[A TD];
ATD=(diag(op2)*ATD')'; 

