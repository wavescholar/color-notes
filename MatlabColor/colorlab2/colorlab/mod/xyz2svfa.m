function [svf,S,p,Y]=xyz2svfa(a,b,kc,kp,kf);

% XYZ2SVF computes the value V and the two chromatic coordinates F1 and F2
% in the SVF space, of samples XYZ against a background XYZW. 
%
% The SVF space was designed for reflectant samples on an achromatic
% background and the tristimulus values are normalized to the background.
% Hopefully , the model will work correctly with other stimuli, (such as, for
% instance, Y/YW > 100)
%
% SYNTAX
% ----------------------------------------------------------------------------
% VF1F2=xyz2svfa(XYZ,XYZW,kc,kp,kf)
%
% kc = matrix modifying the cone responses
%
% ko = matrix modifying the opponent responses
%
% XYZ = Tristimulus values of the samples.
%       For N colours, this is a Nx3 matrix.
%
% XYZW = Tristimulus values of the refence white.
%        This variable may contain a single white or a white for each
%        stimulus.
%
% VF1F2 = [V (value) F1 F2 (chromaticity coordinates)]
%
% RELATED FUNCTIONS
% ----------------------------------------------------------------------------
% svf2xyz

a=100*a/b(:,2);
b=b/b(:,2);

n=size(a);

%Linear cone responses
t2c=[0.520 0.589 -0.102;-0.194 0.562 0.034;0.007 -0.015 0.907];
%t2c=[0.3841 0.7391 -0.0650;-0.3471 1.1463 0.087;0 0 0.5610];
% t2c=[0.0629    0.1210   -0.0106;-0.0673    0.2223    0.0169;0         0    0.1655];

SC=(kc*t2c*a')';
SW=(kc*t2c*b')';

%White-Centered linear cone responses
S=[SC(:,1)/SW(1) SC(:,2)/SW(2) SC(:,3)/SW(3)];
%S=(kc*S')';
%Y=a(:,2);
Y=S(:,1)+S(:,2);

%Non-linear cone-responses
v1Y=(((Y-0.43).^0.51)./((Y-0.43).^0.51+31.75)).*(+(Y>=0.43));
VY=40*v1Y;
kVY=0.140+0.175*VY;

v1S1=(+(S(:,1)>=0.43)).*((S(:,1)-0.43).^0.51)./(((S(:,1)-0.43).^0.51)+31.75);
v1S3=(+(S(:,3)>=0.43)).*((S(:,3)-0.43).^0.51)./(((S(:,3)-0.43).^0.51)+31.75);
v2Y=(((Y./kVY-0.1).^0.86)./((Y./kVY-0.1).^0.86+103.2)).*(+(Y./kVY>=0.1));
v2S3=(((S(:,3)./kVY-0.1).^0.86)./((S(:,3)./kVY-0.1).^0.86+103.2)).*(+(S(:,3)./kVY>=0.1));


%First Opponent stages
p(:,1)=v1S1-v1Y;
p(:,2)=(v1Y-v1S3).*(+(S(:,3)<=Y))+(v2Y-v2S3).*(+(S(:,3)>Y));
p=(kp*p')';
F(:,1)=700*p(:,1)-54*p(:,2);
F(:,2)=96.5*p(:,2);
%F(:,1)=1.5*p(:,1)-0.5*p(:,2);
%F(:,2)=0.7*p(:,2);



svf=[VY F];

svf=(kf*svf')';