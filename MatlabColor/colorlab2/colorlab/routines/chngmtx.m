function [M,yw]=chngmtx(MM,yyww,m);

% CHNGMTX  computes the change-of-basis matrix that relates the systems P and P'
% 
% CHNGMTX solves the problem in two different cases (from different initial data):
% 
% 1.- We know:
% 
%       * Tristimulus values of the new color primaries in the old basis: Ti(Pj')
%
% 2.- We know:
% 
%       * Chromatic coordinates of the new color primaries in the old basis: ti(Pj')
%  
%       * The characterization of the new reference white, W': 
%         Chromatic coordinates (in the old basis), ti(W'), and luminance, Y(W'). 
% 
% Besides, CHNGMTX also computes the new trichromatic units from the old ones.
% 
% SYNTAX:
% -------------------------------------------------------------------------------
%
%  [M12,Yw2]=chngmtx(DATA,Yw1,option);
%
%  M12    = The 3*3 change-of-basis matrix that relates the systems 1 and 2 (P and P').
%  
%  Yw2    = Trichromatic units of the new basis (1*3 vector).
%
%  Yw1    = Trichromatic units of the old basis (1*3 vector).
%
%  DATA   = 3*3 matrix with the data to compute the matrix M12. 
%           The interpretation of DATA (case 1 or case 2) depends on the value of 
%           the variable option. See below for details on how to introduce DATA
%           in each case.
%
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
% coor2tri.m
%

if m==1
    M=inv(MM');
%    yw=[MM(1,:)*yyww' MM(2,:)*yyww' MM(3,:)*yyww'];    
    yw=MM*yyww(ones(1,3),:)';
else
    t=[MM(:,1:2) 1-MM(:,1)-MM(:,2)];
    Tw=coor2tri(MM(:,3)',yyww)';
    a=inv(t')*Tw;
    T1=a(1)*t(1,:)';
    T2=a(2)*t(2,:)';
    T3=a(3)*t(3,:)';
    M=inv([T1 T2 T3]);
    yw=[T1'*yyww' T2'*yyww' T3'*yyww']; 
end