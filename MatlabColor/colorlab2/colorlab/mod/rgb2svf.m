function [svf,Y,SC,S,VY,kVY,p]=rgb2svf(a,b);

% RGB2SVF computes the value V and the two chromatic coordinates F1 and F2
% in the SVF space, of samples RGB (Stiles and Burch) against a background RGBW. 
%
% The SVF space was designed for reflectant samples on an achromatic
% background and the tristimulus values are normalized to the background.
% Hopefully , the model will work correctly with other stimuli, (such as, for
% instance, Y/YW > 100)
%
% SYNTAX
% ----------------------------------------------------------------------------
% VF1F2=rgb2svf(RGB,RGBW)
%
% RGB = Tristimulus values of the samples.
%       For N colours, this is a Nx3 matrix.
%
% RGBW = Tristimulus values of the refence white.
%        This variable may contain a single white or a white for each
%        stimulus.
%
% VF1F2 = [V (value) F1 F2 (chromaticity coordinates)]
%
% RELATED FUNCTIONS
% ----------------------------------------------------------------------------
% svf2rgb

a=100*a/b(:,2);
b=b/b(:,2);



n=size(a);

%Linear cone responses
t2c=[0.4002];
%f=fullfile(matlabroot,'toolbox','colorlab','colordat','systems','ciexyz.mat');
%[T_l,Yw]=loadsysm(f);
%S=(t2c*T_l(:,2:4)')';
%normal=sum(S)*(T_l(3,1)-T_l(2,1));
%t2c=100*[1/normal(1) 0 0;0 1/normal(2) 0;0 0 1/normal(3)]*t2c;
SC=(t2c*a')';
SW=(t2c*b')'

%White-Centered linear cone responses
S=[SC(:,1)/SW(1) SC(:,2)/SW(2) SC(:,3)/SW(3)];
Y=a(:,2);

%Non-linear cone-responses
v1Y=(((Y-0.43).^0.51)./((Y-0.43).^0.51+31.75)).*(Y>=0.43);
VY=40*v1Y;
kVY=0.140+0.175*VY;

v1S1=(+(S(:,1)>=0.43)).*((S(:,1)-0.43).^0.51)./(((S(:,1)-0.43).^0.51)+31.75);
v1S3=(+(S(:,3)>=0.43)).*((S(:,3)-0.43).^0.51)./(((S(:,3)-0.43).^0.51)+31.75);
v2Y=(((Y./kVY-0.1).^0.86)./((Y./kVY-0.1).^0.86+103.2)).*(+(Y./kVY>=0.1));
v2S3=(((S(:,3)./kVY-0.1).^0.86)./((S(:,3)./kVY-0.1).^0.86+103.2)).*(+(S(:,3)./kVY>=0.1));


%First Opponent stages
p(:,1)=v1S1-v1Y;
p(:,2)=(v1Y-v1S3).*(+(S(:,3)<=Y))+(v2Y-v2S3).*(+(S(:,3)>Y));


F(:,1)=700*p(:,1)-54*p(:,2);
F(:,2)=96.5*p(:,2);
%F(:,1)=1.5*p(:,1)-0.5*p(:,2);
%F(:,2)=0.7*p(:,2);


svf=[VY F];
