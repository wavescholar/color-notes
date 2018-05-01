function [n]=t2n(T,a,g,coor,utri)

% T2N digital values from tristimulus vectors assuming fixed chromaticities for the guns
% 
% T2N is called many times from TRI2VAL.
% It may give rise to digital values bigger than 1.
% 
%  SYNTAX
%  -------------------------------------------------------------------------------
%
%  n=t2n(T,a,g,tm_fixed,Yw);
%
%  INPUT Variables
%
%  T         = Input color-like variable (N*3 variable) with N colors (tristimulus vectors).
%  
%  Yw        = Trichromatic units
%  
%  tm_fixed  = 3*2 matrix that contains the chromaticities of the R, G and B guns for 
%              a given calibration point (this is a particular subset of tm see CALIBRAT.M).
%  
%  a         = 1*3 vector including the constants a_i of the gamma relation for each gun.
%              (see CALIBRAT.M)
%  
%  g         = 1*3 vector including the constants g_i of the gamma relation for each gun.
%              (see CALIBRAT.M)
%
%  OUTPUT Variables
%  
%  n       = Output color-like variable (N*3 variable) with N colors (digital values).
%            This is a colormap ready to use in the MATLAB environment.
% 
%  REQUIRED FUNCTIONS
%  ---------------------------------------------------------------------------------
%  tri2lum.m  lum2niv.m
%


Y=tri2lum(T,coor,utri);
n=lum2niv(Y,a,g);