% STARTCOL opens two dialog boxes to load the data required for Colorlab to work
%
% In order to start working with colorlab you need to define a reference color
% system an you need the CRT calibration data to display color images.
% (see loadsys.m, loadmon.m and calibrat.m)
%
% The names given to these variables are:
%  
%  T_l = Color matching functions (spectral-like, N*4 variable)
%  Yw  = Trichromatic units (1*3 vector)
%  Msx = 3*3 change-of-basis matrix that relates the system at hand to the CIEXYZ system.
%
%  tm  = 7*N matrix that contains the chromaticities of the R, G and B guns for 
%        N calibration points of the digital value (see CALIBRAT.M for details).
%        The chromaticities are given in the system at hand eventhough they are stored 
%        in the CIEXYZ system (this is why Msx is needed). 
%  a   = 1*3 vector including the constants a_i of the gamma relation for each gun.
%  g   = 1*3 vector including the constants g_i of the gamma relation for each gun.
%
%  REQUIRED FUNCTIONS
%  ---------------------------------------------------------------------------------------
%   loadsys.m
%   loadmon.m  
%  coor2tri.m
%  newbasis.m
%  
 

[T_l,Yw,Msx]=loadsys;
[tm,a,g]=loadmon(Msx);