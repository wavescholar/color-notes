function lms=gancon(lmst,lmsf,modelo,sigma)

% GANCON computes the gain-controlled cone response within the
% specified model. 
%
% SYNTAX
% ----------------------------------------------------------------------------
% LMST = Tristimulus values of the tests in the lineal cone-space of 
%        the corresponding model (Nx3 matrix for N tests).
%
% LMSF = Tristimulus values of the background in the lineal cone-space of 
%        the corresponding model. The size of LMSF must be the same than that
%        of LMST. If all the stimuli in LMST are seen against the same 
%        background, this must be repeated the appropriate number of times.
%
% MODEL = Integer (1-13) identifying the model. See XYZ2ATD for details.
%
% SIGMA = Scalar controlling the non-linearity. See XYZ2CON for details.
%
% LMS = Gain-controlled cone responses to the test stimuli.
%
% RELATED FUNCTIONS
% ----------------------------------------------------------------------------
% INGANCON
%
%Function used by XYZ2CON


m=size(lmst);
imax=m(1);
if lmsf==0
	lmsf=[0 0 0];
end
if modelo<=7 | modelo==12
	lms=lmst';
elseif modelo==8
	lms=lmst'.*(1-0.99*lmsf'./(0.05+lmsf'));
elseif modelo>=9 & modelo<12
   lms=lmst'.*(sigma./(lmsf'+sigma));
end
lms=lms';