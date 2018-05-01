function [M2X,M12,f_igual2,utri2,coco2]=defsysg(YW,f_igual1,utri1,M1X,coco1);

% DEFSYS graphic definition of a new color system
% 
% DEFSYS opens a window for the user to choose the chromaticities of the 
% new primaries and the new white.
% The only numerical value required by DEFSYS regarding the new system is 
% the luminance of the new white. 
% DEFSYS returns the data that defines a color system and other convenient 
% data:
% - The color matching functions in the new system, T_l2.
% - The trichromatic units of the new system, Yw2.
% - The change-of-basis matrix, M2x, that relates the new system, s2, 
%   to the CIE XYZ system.
% - (Not necessary but convenient) the change-of-basis matrix, M12, that
%   relates the 'new' system, s2, to the 'old' system, s1.
% - (Also convenient in Colorlab are) the chromaticities of the monitor, tm2.
%
% SYNTAX:
% -------------------------------------------------------------------------------
%
%  [M2x,M12,T_l2,Yw2,tm2]=defsys(YW2,T_l1,Yw1,M1x,tm1);
%
%  YW2    = Luminance (in cd/m2) of the new white.
%  T_l1   = Color matching functions in the old basis (spectral-like variable, N*4 matrix).
%  Yw1    = Trichromatic units of the old basis (1*3 vector).
%  M1x    = The 3*3 change-of-basis matrix that relates the old system, s1, to the CIEXYZ system.
%  tm1    = Chromaticities of the monitor in the old basis (7*N matrix).
%
%  M2x    = The 3*3 change-of-basis matrix that relates the new system, s2, to the CIEXYZ system.
%  M12    = The 3*3 change-of-basis matrix that relates the old system, s1, to the new one, s2.
%  T_l2   = Color matching functions in the new basis (spectral-like variable, N*4 matrix).
%  Yw2    = Trichromatic units of the new basis (1*3 vector).
%  tm2    = Chromaticities of the monitor in the new basis (7*N matrix).
%
% REQUIRED FUNCTIONS:
% -------------------------------------------------------------------------------
% chngmtx.m, coor2tri.m 
% newbasis.m
% defcroma.m, colordgm.m
% colord_c.m
% tri2coor.m
% lp2coor.m
% replocus.m, mini.m, maxi.m, niv2coor.m, ganadora.m

disp(' ')
disp(' GRAPHIC COLOR')
disp(' SYSTEM DEFINITION')
disp(' ')
disp(' Select (in this order) the chromaticities of')
disp(' the new primaries 1, 2, 3, and the white reference.')
disp(' ')
disp(' ')
disp(' Press any key to continue...')
disp(' ')
disp(' ')
pause

%t=defcroma(f_igual1,coco1,1,fig,color); 
t=defcroma(f_igual1,coco1);
[M12,utri2]=chngmtx([t(1:3,:) [t(4,:) YW]'],utri1,2); 
f_igual2=newbasis(f_igual1(:,2:4),M12);
f_igual2=[f_igual1(:,1) f_igual2];
s=size(coco1);
Tmon1=coor2tri([[coco1(2:3,:)';coco1(4:5,:)';coco1(6:7,:)'] ones(3*s(2),1)],utri1);
Tmon2=newbasis(Tmon1,M12);
tmon2=Tmon2./[sum(Tmon2')' sum(Tmon2')' sum(Tmon2')'];
tmon2=tmon2(:,1:2);
coco2(1:2,:)=[tmon2(1:s(2),:)]';
coco2(3:4,:)=[tmon2(s(2)+1:2*s(2),:)]';
coco2(5:6,:)=[tmon2(2*s(2)+1:3*s(2),:)]';
coco2=[coco1(1,:);coco2];
M2X=M1X*inv(M12);