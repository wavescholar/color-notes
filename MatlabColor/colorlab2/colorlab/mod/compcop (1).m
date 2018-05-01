function ATDg=compcop(ATD,etapa,modelo)

% COMPCOP applies a compressive non-linearity to the linear
% ATD responses of a given STAGE of certain MODEL.
%
% SYNTAX
% ----------------------------------------------------------------------------
% ATDG=COMPCOP(ATD,STAGE,MODEL)
%
% ATD = Linear ATD responses to a set of stimuli.
%       For N stimuli, this is a Nx3 matrix.
%
% STAGE = 1 or 2, depending on whether the ATD responses correspond
%         to the first or the second opponent stage of the model.
%
% MODEL = Integer (1-13) identifying the model. See XYZ2ATD for details.
%         Only models 8-11 have this mechanism.
%            MODEL=8     Guth 90
%                        F'=F/(|F|+0.008)
%            MODEL=9     Guth 93
%                        F'=F/(|F|+200)
%            MODEL=10     Guth 94
%                        F'=F/(|F|+200)
%            MODEL=11     Guth 95
%                        F'=F/(|F|+200)
%
% ATDG = Non-linear ATD responses.
%        For N stimuli, this is a Nx3 matrix.
%
% RELATED FUNCTIONS
% ----------------------------------------------------------------------------
% INCOMCOP, CON2ATD and XYZ2ATD
%
%Function used by CON2ATD.

if modelo<4
   disp('The model specified does not have opponent stages');
else
if modelo==8
	if etapa==1 | etapa==2
	ATDg=ATD./(0.008+abs(ATD));  
	end
elseif modelo>=9 & modelo<12
   ATDg=ATD./(200+abs(ATD));
else
   ATDg=ATD;
end
end