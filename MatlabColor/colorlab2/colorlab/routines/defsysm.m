function [M2X,M12,f_igual2,utri2,coco2]=defsysm(DATOS,caso,f_igual1,utri1,M1X,coco1);

% DEFSYSM defines a new color system from (manually) given information. 
% 
% The data that define a new color system, s2, are: 
% - The color matching functions, T_l2
% - The trichromatic units, Yw2
% - The change-of-basis matrix, M2x, that relates the system, s2, to the system CIE XYZ.
% - (Not necessary but convenient) the change-of-basis matrix, M12, that relates the 
%   'new' system, s2, to the 'old' system s1.
% - (Also convenient in Colorlab are) the chromaticities of the monitor, tm2.
% 
% DEFSYSM solves the problem from the old data in two different cases 
% (from different initial data defining the new system):
% 
% Case 1: We know,
% 
%       * Tristimulus values of the new color primaries in the old basis: Ti(Pj')
%
% Case 2: We know,
% 
%       * Chromatic coordinates of the new color primaries in the old basis: ti(Pj')
%  
%       * The characterization of the new reference white, W': 
%         Chromatic coordinates (in the old basis), ti(W'), and luminance, Y(W'). 
% 
% SYNTAX:
% -------------------------------------------------------------------------------
%
%  [M2x,M12,T_l2,Yw2,tm2]=defsysm(DATA,option,T_l1,Yw1,M1x,tm1);
%
%  M2x    = The 3*3 change-of-basis matrix that relates the new system, s2, to the CIEXYZ system.
%  M12    = The 3*3 change-of-basis matrix that relates the old system, s1, to the new one, s2.
%  T_l2   = Color matching functions in the new basis.
%  Yw2    = Trichromatic units of the new basis (1*3 vector).
%  tm2    = Chromaticities of the monitor in the new basis (7*N matrix).
%
%  T_l1   = Color matching functions in the old basis.
%  Yw1    = Trichromatic units of the old basis (1*3 vector).
%  M1x    = The 3*3 change-of-basis matrix that relates the old system, s1, to the CIEXYZ system.
%  tm1    = Chromaticities of the monitor in the old basis (7*N matrix).
%  DATA   = 3*3 matrix with the data to compute the matrix M12. 
%           The interpretation of DATA (case 1 or case 2) depends on the value of 
%           the variable option. See below for details on how to introduce DATA
%           in each case.
%  option = Variable that controls the case (the meaning of DATA).
%           If opt = 1 
%              we know the tristimulus values of the new color primaries Ti(Pj')
%              In this case, you have to introduce DATA in this way:
%
%                                /                             \
%                               |  T1(P1')   T2(P1')   T3(P1')  |
%                        DATA = |  T1(P2')   T2(P2')   T3(P2')  |
%                               |  T1(P3')   T2(P3')   T3(P3')  |
%                                \                             /
%                i.e:
%                DATA = [T1(P1') T2(P1') T3(P1');T1(P2') T2(P2') T3(P2');T1(P3') T2(P3') T3(P3')];
%
%           If opt = 2 
%              we know the chromaticities of the new color primaries and the white
%              In this case, you have to introduce DATA in this way:
%
%                                /                            \
%                               |  t1(P1')   t2(P1')   t1(W')  |
%                        DATA = |  t1(P2')   t2(P2')   t2(W')  |
%                               |  t1(P3')   t2(P3')    Y(W')  |
%                                \                            /
%              i.e:
%              DATA = [t1(P1') t2(P1') t1(W');t1(P2') t2(P2') t2(W');t1(P3') t2(P3') Y(W')];
%
%
% REQUIRED FUNCTIONS:
% -------------------------------------------------------------------------------
% chngmtx.m, coor2tri.m 
% newconst.m, newbasis.m

[M12,utri2]=chngmtx(DATOS,utri1,caso);
[f_igual2,utri2,M2X,coco2]=newconst(M12,f_igual1,utri1,M1X,coco1);
