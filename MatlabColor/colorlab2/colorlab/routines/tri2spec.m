function [palr]=tri2spec(palt,R,S,Y,f_igual,utri)

% TRI2SPEC asign reflectance(s) to tristimulus vector(s). 
% 
% Sometimes you may want to look for a stimulus (a reflectance) that 
% gives rise to a particular color under a given illuminant. 
% This is not a well defined transform because all metameric stimulus 
% give rise to the same color. 
% Despite this is a non invertible problem, a particular or approximate 
% solution may be useful for stimuli design. 
% 
% For each tristimulus vector of the input, TRI2SPEC associates a 
% reflectance from the set of 'target reflectances'. 
% TRI2SPEC selects the reflectance that gives rise to the closest 
% chromaticity and scales the reflectance to fit the luminance 
% of the input color. (Incorrect) Eclidean distance is used to 
% compute the chromaticity differences. 
% A relative illuminant has to be introduced with an additional 
% luminance (in cd/m2). 
% 
% CAUTION: Note that for low-energy illuminants it may be necessary 
%          to apply high factors on the reflectances to obtain the 
%          required luminance. 
%          This may lead to reflectances > 1 for some wavelengths 
%          (this is why not all chromaticities are generable from 
%          physical reflectances).  
%          It may be necessary to apply physical constraints 
%          (reflectances < 1) to the output of this routine.
%
% SYNTAX
% --------------------------------------------------------------------
%
% RT=tri2spec(T,R,S,Y,T_l,Yw);
% 
% T   = Input tristimulus vectors (color-like variable)
% 
% R   = Target reflectances to choose from (spectral-like variable).
%       Hint: The file munsell.mat contain a set of reflectances that 
%             covers a big region of the chromaticity space, so it may 
%             be useful in this routine.
%
% S   = Illuminant (spectral-like variable).
%
% Y   = Luminance of the illuminant.
%
% T_l = Color matching functions.
%
% Yw  = Trichromatic units.
%
% RT  = Output reflectances (spectral-like variable)
%
% REQUIRED FUNCTIONS
% --------------------------------------------------------------------
% spec2tri.m
% tri2coor.m
% ganadora.m

[Tref,RR]=spec2tri(f_igual,5,R,S,Y,utri);
tref=tri2coor(Tref,utri);
tpal=tri2coor(palt,utri);
sp=size(palt);
sr=size(R);
palr=zeros(sr(1),sp(1)+1);
palr(:,1)=R(:,1);
for i=2:sp(1)+1
    pos=ganadora(tref(:,1:2),tpal(i-1,1:2));
    fac=tpal(i-1,3)/tref(pos,3);
    palr(:,i)=fac*R(:,pos+1);
end