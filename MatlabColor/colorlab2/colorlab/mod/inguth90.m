function Lum=inguth90(Tdn)

% INGUTH90 undoes the luminance normalization of Guth's ATD90.
%
% SYNTAX
% ----------------------------------------------------------------------------
% Y=INGUTH90(TDN)
%
% TDN = Normalized trolands.
%
%   Y = Luminance (cd/m2).
%
% RELATED FUNCTIONS
% ----------------------------------------------------------------------------
% GUTH90
%
%Function used by CAMBIAL.



td=100*Tdn/0.0125;
Lum=td2lum(td);