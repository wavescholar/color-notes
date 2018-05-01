function [XYZ,SC,S,p,Y]=svf2xyz(svf,XYZW);

% SVF2XYZ computes the tristimulus values, in CIE-1931 space of the stimuli
% whose descriptors in the SVF space are VF1F2 when the background is XYZW.
%
% SYNTAX
% ----------------------------------------------------------------------------
% XYZ=svf2xyz(VF1F2,XYZW)
%
% VF1F2 = [V (value) F1 F2 (chromaticity coordinates)]
%
% XYZW = Tristimulus values of the refence white.
%        This variable may contain a single white or a white for each
%        stimulus.
%
% XYZ = Tristimulus values of the samples.
%       For N colours, this is a Nx3 matrix.
%
% REQUIRED FUNCTIONS
% ----------------------------------------------------------------------------
% acop mixi lator
%
% RELATED FUNCTIONS
% ----------------------------------------------------------------------------
% xyz2svf


b=XYZW/XYZW(:,2);
t2c=[0.520 0.589 -0.102;-0.194 0.562 0.034;0.007 -0.015 0.907];
%t2c=[0.3841 0.7391 -0.0650;-0.3471 1.1463 0.087;0 0 0.5610];
%t2c=[0.0629    0.1210   -0.0106;-0.0673    0.2223    0.0169;0         0    0.1655];
%f=fullfile(matlabroot,'toolbox','colorlab','colordat','systems','ciexyz.mat');
%[T_l,Yw]=loadsysm(f);
%S=(t2c*T_l(:,2:4)')';
%normal=sum(S)*(T_l(3,1)-T_l(2,1));
%t2c=100*[1/normal(1) 0 0;0 1/normal(2) 0;0 0 1/normal(3)]*t2c;
%clear S;
SW=(t2c*b')';
p(:,2)=svf(:,3)/96.5;
p(:,1)=(svf(:,2)+54*p(:,2))/700;
%p(:,2)=svf(:,3)/0.7;
%p(:,1)=(svf(:,2)+0.5*p(:,2))/1.5;

v1Y=svf(:,1)/40;
Y=0.43+(31.75*v1Y./(1-v1Y)).^(1/0.51);
v1S1=p(:,1)+v1Y;
S(:,1)=0.43+(31.75*v1S1./(1-v1S1)).^(1/0.51);
KVY=0.140+0.175*svf(:,1);
v2Y=((Y./KVY-0.1).^0.86)./((Y./KVY-0.1).^0.86+103.2);


v1S3=v1Y-p(:,2);
v2S3=v2Y-p(:,2);

S3a=(+(v1S3<1 & v1S3>=0)).*(0.43+(31.75*v1S3./(1-v1S3)).^(1/0.51));
S3b=(+(v2S3<1 & v2S3>=0)).*KVY.*(0.1+(103.2*v2S3./(1-v2S3)).^(1/0.86));


S(:,3)=S3a.*(+(S3a<=Y & S3a>=0.43))+S3b.*(+(S3b>Y));
%S(:,3)=S(:,3).*(p(:,2)~=0)+Y.*(p(:,2)==0);

SC(:,1)=S(:,1)*SW(1);	
SC(:,3)=S(:,3)*SW(3);

XZS2=(inv([t2c(:,[1 3]) [0 -1 0]'])*[[1 0;0 0;0 1] -t2c(:,2)]*[SC(:,[1 3]) Y]')';
SC(:,2)=XZS2(:,3);
S(:,2)=SC(:,2)/SW(2);
XYZ(:,1)=XZS2(:,1);
XYZ(:,3)=XZS2(:,2);
XYZ(:,2)=Y;

XYZ=XYZ.*XYZW(ones(1,size(XYZ,1)),[2 2 2])/100;
