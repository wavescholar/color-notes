function t=defcroma(f_igual,coord)

% DEFCROMA graphic definition of N chromaticities
%
% DEFCROMA opens a window with the current chromatic diagram for
% the user to choose the chromaticities from.
% DEFCROMA returns the selected chromaticities.
%
% SYNTAX
% ---------------------------------------------------------------------------------------
%   
%  t=defcroma(T_l,tm);
%
%  T_l        = Color Matching Functions in the current basis (N*4 spectral-like matrix).
% 
%  tm         = Chromaticities of the monitor. 7*N matrix with the calibration data.
%               (see CALIBRAT.M or LOADMON.M).
%
% REQUIRED FUNCTIONS
% ---------------------------------------------------------------------------------------
% colordgm.m
% tri2coor.m
% lp2coor.m
% replocus.m, mini.m, maxi.m, niv2coor.m, ganadora.m
% 

Yw=[1 1 1];
linecolors=[0 0 0;0 0 1;0 0 0.5;0 0.5 0;0.5 0 0];
linewidths=[0.5 0.5 0.5 0.5 0.5];
linestyles=['- ';'- ';'- ';'- ';': '];
fontsizes=[10 12];
S=sum(f_igual(:,2:4)')';
limits=[min(f_igual(:,2)./S) max(f_igual(:,2)./S) min(f_igual(:,3)./S) max(f_igual(:,3)./S)];

replocus(f_igual,coord,limits,3,linecolors,linewidths,linestyles,fontsizes)
text(.3,.99, 'Select the chromaticities ');
text(.3,.92, 'using the left button of the mouse...');
text(.3,.85, 'press the right button when finished');
hold on
[t]=ginput(1);


%colordgm(t,2,f_igual,0,coord);
colordgm(t,2,f_igual,Yw,'showtriang',{3,coord},'show_numb',1);

hold on
cond=0;
tt=[0 0];
boton=1;
while boton<3,
      [tt(1),tt(2),boton]=ginput(1);
      if boton==1
         t=[t;tt];
         colordgm(t,2,f_igual,Yw,'showtriang',{3,coord},'show_numb',1);hold on;
         
      end    
end      
hold off   
%colord_c(t,2,f_igual,0,coord,symb,show_lin_numb,showtriang,linecolors,linewidths,linestyles,fontsizes);
colordgm(t,2,f_igual,Yw,'showtriang',{3,coord},'show_numb',1);
%text(.3,.99, 'Your selection');
text(.3,.92, 'Your selection!');
%text(.3,.85, 'press any key when finished');
