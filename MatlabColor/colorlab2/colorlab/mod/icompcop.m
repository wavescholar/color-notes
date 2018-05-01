function ATD=icompcop(ATDg,etapa,modelo)

% ICOMPCOP is the inverse of COMPCOP. Returns uncompressed ATD responses from the 
% compresed ATDC responses of the specified STAGE and MODEL. See COMPCOP for details.
%
% SYNTAX
% ----------------------------------------------------------------------------
% ATD=ICOMPCOP(ATDC,STAGE,MODEL)
%
%Function used by ATD1ATD2 and ATDF2CON.

if modelo<4
   disp('The model specified does not have opponent stages');
else
if modelo<=7 | modelo==12 | modelo==13
	ATD=ATDg;
elseif modelo==8
	if etapa==1 | etapa==2
	ATD=0.008*ATDg./(1-abs(ATDg));
	end
elseif modelo>=9 & modelo<12
	ATD=200*ATDg./(1-abs(ATDg));
end
end