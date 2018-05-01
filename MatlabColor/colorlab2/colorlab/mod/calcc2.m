function f=calcc2(x,Cl,L,Fc2,Ld)

% CALCC2 computes C for the third step of the XYZ2LLAB transform. This functions
% does not serve for anything else.
%
% SYNTAX
% ----------------------------------------------------------------------------
% F=CALCC2(x,Cl,L,Fc2,Ld)
%
% Function called by XYZ2LLAB.

f=abs(Cl-((0.7+0.02*L-0.0002*L^2)*25*log(1+0.05*x)*Fc2*(1+0.47*log10(Ld)-0.057*(log10(Ld)^2))));