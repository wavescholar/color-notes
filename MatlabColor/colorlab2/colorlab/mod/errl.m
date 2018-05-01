function e=errl(x,p)

% ERRL helps to compute the value of the achromatic second-stage descriptor 
% (A2) of the different versions of Guth's non-linear model, so that the
% first-stage descriptors computed from the second-stage descriptors
% [A2 A2*S*COS(H) A2*S*SIN(H)] yield brightness B 
%
% SYNTAX
% ----------------------------------------------------------------------------
% e=errl(Ao,[B S*COS(H) S*SIN(H) modelo])
%
%ERRL is an auxiliary function for PERC2ATD and has no other use whatever. 


atd1=atd1atd2([abs(x) p(2)*abs(x) p(3)*abs(x)],2,p(4));
e=(p(1)-sqrt(atd1*atd1')).^2;