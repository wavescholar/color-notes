function tdn=nguth90(Lum)

% NGUTH90 normalizes the luminance to fullfil the conditions of
% Guth's ATD90 (Y=0.0125 equals 100 Td).
%
% SYNTAX
% ----------------------------------------------------------------------------
% TDN=nguth90(Y)
%
% Y   = Luminance (cd/m2).
%
% TDN = Normalized trolands.
%
% RELATED FUNCTIONS
% ----------------------------------------------------------------------------
% inguth90
%
%Function used by CAMBIAL.




td=lum2td(Lum);
tdn=td*0.0125/100;

