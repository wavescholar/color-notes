function [f_igual2,utri2,M2X]=newconst(M12,f_igual1,utri1,M1X);

% NEWCONST computes the constants that define a new color basis
% 
% The constants that define a new color basis are:
% - Color matching functions, T_l
% - Trichromatic units, Yw
% - Change-of-basis matrix, Msx, that relates the system, s, to the system CIE XYZ.
% 
% SYNTAX:
% -------------------------------------------------------------------------------
%
%  [T_l2,Yw2,M2x]=newconst(M12,T_l1,Yw1,M1x);
%  
%  M12  = 3*3 Change-of-basis matrix that relates the system 1 to the system 2.
%  T_l1 = Color matching functions in the system 1 (Spectral-like variable, N*4 matrix).
%  Yw1  = Trichromatic units of the system 1 (1*3 vector).
%  M1x  = 3*3 Change-of-basis matrix that relates the system 1 to the CIEXYZ system.
%
%  T_l2 = Color matching functions in the system 2 (Spectral-like variable, N*4 matrix).
%  Yw2  = Trichromatic units of the system 2 (1*3 vector).
%  M2x  = 3*3 change-of-basis matrix that relates the system 2 to the CIEXYZ system.
%  
% REQUIRED FUNCTIONS:
% -------------------------------------------------------------------------------
% newbasis.m
% coor2tri.m
% 

f_igual2=newbasis(f_igual1(:,2:4),M12);
f_igual2=[f_igual1(:,1) f_igual2];
%s=size(coco1);
%Tmon1=coor2tri([[coco1(2:3,:)';coco1(4:5,:)';coco1(6:7,:)'] ones(3*s(2),1)],utri1);
%Tmon2=newbasis(Tmon1,M12);
%tmon2=Tmon2./[sum(Tmon2')' sum(Tmon2')' sum(Tmon2')'];
%tmon2=tmon2(:,1:2); 
%coco2(1,:)=coco1(1,:); 
%coco2(2:3,:)=[tmon2(1:s(2),:)]'; 
%coco2(4:5,:)=[tmon2(s(2)+1:2*s(2),:)]'; 
%coco2(6:7,:)=[tmon2(2*s(2)+1:3*s(2),:)]'; 
T1=inv(M12)*[1;0;0]; 
T2=inv(M12)*[0;1;0]; 
T3=inv(M12)*[0;0;1]; 
utri2=[utri1*T1 utri1*T2 utri1*T3]; 
 
M2X=M1X*inv(M12); 