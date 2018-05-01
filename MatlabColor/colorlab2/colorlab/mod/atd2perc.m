function [perc]=atd2perc(atd2,modelo)

% ATD2PERC computes the perceptual descriptors Brightness (B), Hue (H) and
% Saturation (S) of a set of stimuli from the last opponent-stage descriptors
% in a given model. 
%
% SYNTAX
% ----------------------------------------------------------------------------
% BHS=ATD2PERC(ATDE,MODEL)
%
% ATDE  = ATD descriptors of the last stage of the model.
%         If the model has only one opponent stage, ATDE=ATD1;
%         if the model has two opponent stages, ATDE=ATD2;
%         For N colours, ATDE is a Nx3 matrix.
%
% model = Number idenfifying the model (1-13). See XYZ2ATD for details.
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
% RELATED FUNCTIONS
% ----------------------------------------------------------------------------
% PERC2ATD, XYZ2ATD and ATD1ATD2.
%


if modelo<4
   disp('This model does not have opponent stages.');
elseif modelo==4
 atd1=atd2;     
 B=sum(abs(atd1'))';
 S=sum(abs(atd1(:,2:3)'))'./sum(abs(atd1'))';
 H=abs(atd1(:,2))./sum(abs(atd1(:,2:3)'))';
 perc=[B H S];
elseif modelo>=5 & modelo<12 
 atd1=atd1atd2(atd2,2,modelo);
 num=size(atd2);
 imax=num(1);
 B=sqrt(atd1(:,1).^2+atd1(:,2).^2+atd1(:,3).^2);
 H=atan2(atd2(:,3),atd2(:,2))+2*pi*(atan2(atd2(:,3),atd2(:,2))<0);
 S=sqrt(atd2(:,2).^2+atd2(:,3).^2)./atd2(:,1);
 perc=[B H S];
end