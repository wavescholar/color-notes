function [atd]=perc2atd(LHS,modelo)

% PERC2ATD computes the ATD descriptors at the last stage of the specified
% model from the perceptual descriptors of a set of stimuli.
%
%
% SYNTAX
% ----------------------------------------------------------------------------
% ATD=perc2atd(BHS,model)
%
% BHS   = For N colours, Nx3 matrix containing in the first column the Brightness
%         (B), in the second the hue angle (0<=H<=2*pi) and in the third the
%         saturation (S) of each input stimulus.
%
%         In model 4, B=sum(abs(ATD1)) 
%                     H=T1/sum(abs(T1,D1))
%                     S=sum(abs(T1,D1))/sum(abs(ATD1)).
%
%         In models 5-11 B is the norm of the ATD1 vector. In models 5-7, H is
%         the angle defined by (T1,D1) and S the norm of (T1,D1) divided by A1.
%         In models 8-11, the definitions of hue and saturation are applied at
%         the second opponent stage descriptors.
% 
% model = Number idenfifying the model (1-13). See XYZ2ATD for details.
%         If model=4, only the absolute values of A, T and D may be computed.
%
% ATD   = ATD descriptors of the last stage of the model.
%         If the model has only one opponent stage, ATDE=ATD1;
%         if the model has two opponent stages, ATDE=ATD2;
%         For N colours, ATDE is a Nx3 matrix.
%
% REQUIRED FUNCTIONS
% ----------------------------------------------------------------------------
% errl
%
% RELATED FUNCTIONS
% ----------------------------------------------------------------------------
% atd2perc, xyz2atd, atd2xyz, atd1atd2.
%
%
%See also ATD2XYZ, XYZ2ATD and ATD1ATD2. 

if modelo<4
  disp('This model does not have opponent stages.');
elseif modelo==4
   abT=LHS(:,1).*LHS(:,2).*LHS(:,3);
   abD=LHS(:,1).*LHS(:,3).*(1-LHS(:,2));
   A=LHS(:,1).*(1-LHS(:,3));
   atd=[A abT abD];
elseif modelo>=5 & modelo<8
  a=LHS(:,1)./(sqrt(1+LHS(:,3).^2));
  atd=[a a.*LHS(:,3).*cos(LHS(:,2)) a.*LHS(:,3).*sin(LHS(:,2))];
elseif modelo>=8 & modelo<12
  n=size(LHS);
  atd=zeros(n(1),3);
  for i=1:n(1)
    %opciones=zeros(1,18);
    %opciones(1)=0;
    %opciones(2)=1e-15;
    %opciones(3)=1e-15;
    %opciones(14)=1000;
    opciones = optimset('MaxIter',1000,'TolX',1e-15,'TolFun',1e-15,'Display','off') ;
    p=[LHS(i,1) LHS(i,3)*cos(LHS(i,2)) LHS(i,3)*sin(LHS(i,2)) modelo];
    a2=abs(fminsearch('errl',LHS(i,1)/100,opciones,p));
    t2=LHS(i,3)*cos(LHS(i,2))*a2;
    d2=LHS(i,3)*sin(LHS(i,2))*a2;
    atd(i,:)=[a2 t2 d2];
  end
 end
