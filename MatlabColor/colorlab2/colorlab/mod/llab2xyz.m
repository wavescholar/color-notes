function T=llab2xyz(Llab,Tod,Ld,Ybd,md)

% LLAB2XYZ computes the inverse of the descriptors LCH in the LLAB space.
%
% SYNTAX
% ----------------------------------------------------------------------------
% XYZ=LLAB2XYZ(LCH,XYZW,YW,YB,MO)
%
% LCH = [L C H(º)] in LLAB space. For N colours, this is a Nx3 matrix.
%
% XYZW = Relative tristimulus values of the reference white.
%
% YW   = Luminance (cd/m2) of the reference white (1x1).
%
% YB   = Luminance factor of the background (1x1).
%
% MO   = Parameter describing the observation conditions:
%          M0=1.....reflection samples, average surround, field>4º
%	        M0=2.....reflection samples, average surround, field<4º
%	        M0=3.....television and VDU, dim surround
%	        M0=4.....cut-sheet transparency in dim surround
%	        M0=5.....35 mm projection transparency in dark surround
%
% XYZ = Relative tristimulus values of the samples.
%       For N colours, this is a Nx3 matrix.
%
% REQUIRED FUNCTIONS
% ----------------------------------------------------------------------------
% CALCC2
%
% RELATED FUNCTIONS
% ----------------------------------------------------------------------------
% XYZ2LLAB
%





if md==1
	D2=1;
	Fs2=3;
	Fl2=0;
	Fc2=1;
elseif md==2
	D2=1;
	Fs2=3;
	Fl2=1;
	Fc2=1;
elseif md==3
	D2=0.7;
	Fs2=3.5;
	Fl2=1;
	Fc2=1;
elseif md==4
	D=1;
	Fs2=5;
	Fl2=1;
	Fc2=1.1;
elseif md==5
	D2=0.7;
	Fs2=4;
	Fl2=1;
	Fc2=1;
end
L=Llab(:,1);
Cl=Llab(:,2);
hl=Llab(:,3);
M=[0.8951 0.2664 -0.1614;-0.7502 1.7135 0.0367;0.0389 -0.0685 1.0296];
t=size(L);
OPTIONS(1)=0;
OPTIONS(2)=1e-12;
OPTIONS(3)=1e-12;
OPTIONS(14)=1000;

% Para obtener los triestimulos en el campo de destino

z=1+Fl2*(Ybd/100)^0.5;

for i=1:t(1)
	if L(i)>116*(0.008856)^(1/Fs2)-16;
		Yr(i)=100*((L(i)+16)/116)^(Fs2/z);
	else
		Yr(i)=(100*(((L(i)+16)/116)^(1/z)-16/116))*0.008856/((0.008856)^(1/Fs2)-16/116);

	end

	C(i)=fmins('calcc2',Cl(i)/5,OPTIONS,[],Cl(i),L(i),Fc2,Ld);
%C(i)=fmins('calcc',Cl(i),OPTIONS,[],Cl(i),Fc2,Ld);
	A(i)=C(i)*cos(hl(i)*pi/180);
	B(i)=C(i)*sin(hl(i)*pi/180);
end

for i=1:t(1)
	if Yr(i)>0.008856
		fyr(i)=(Yr(i)/100)^(1/Fs2);
	else
		fyr(i)=((0.008856^(1/Fs2)-16/116)/0.008856)*(Yr(i)/100)+16/116;
	end

	fxr(i)=A(i)/500+fyr(i);
	fzr(i)=fyr(i)-B(i)/200;

	if fxr(i)>(0.008856)^(1/Fs2)
		Xr(i)=95.05*fxr(i)^Fs2;
	else
		Xr(i)=(95.05*(fxr(i)-16/116))/((0.008856^(1/Fs2)-16/116)/0.008856);
	end

	if fzr(i)>0.008856^(1/Fs2)
		Zr(i)=108.88*fzr(i)^Fs2;
	else
		Zr(i)=(108.88*(fzr(i)-16/116))/((0.008856^(1/Fs2)-16/116)/0.008856);
	end
end

% Para calcular (Xd Yd Zd) bajo el campo de destino

Mod=M*[Tod(1)/Tod(2);1;Tod(3)/Tod(2)];
Mor=M*[95.05/100;1;108.88/100];

for i=1:t(1)
	Mr(:,i)=(M*[Xr(i)/Yr(i);1;Zr(i)/Yr(i)]);
end
Mr=Mr';

% Respuestas R G y B bajo condiciones de destino

b=(Mor(3)/Mod(3))^0.0834;
k=1;for i=1:t(1)
	R(k,1)=(D2*Mod(1)/Mor(1)+1-D2)*Mr(i,1);
	R(k,2)=(D2*Mod(2)/Mor(2)+1-D2)*Mr(i,2);

	if Mr(i,3)>=0
		R(k,3)=(D2*Mod(3)/(Mor(3)^b)+1-D2)*(Mr(i,3)^b);
	else
		R(k,3)=-(D2*Mod(3)/(Mor(3)^b)+1-D2)*(abs(Mr(i,3)))^b;
	end
	k=k+1;
end


% T= matriz de valores triestimulo de la muestra bajo condiciones de
% destino

for i=1:t(1)
	T(:,i)= inv(M)*[R(i,1)*Yr(i); R(i,2)*Yr(i); R(i,3)*Yr(i)];
end
T=T';