function [T]=n2t(n,a,g,coor,utri)

% N2T computes tristimulus vectors from digital values for fixed gun chromaticities
%   
% SYNTAX
% ------------------------------------------------------
% T=n2t(n,a,g,fixed_chro_guns,utri);
%
% REQUIRED FUNCTIONS
% ------------------------------------------------------
% niv2lum.m   lum2tri.m

Y=niv2lum(n,a,g);
T=lum2tri(Y,coor,utri);
