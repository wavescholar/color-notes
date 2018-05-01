function Llabch=xyz2llab(Ts,Tos,Ls,Ybs,mo)

% XYZ2LLAB computes the lightness (L), the  opponent coordinates a and b,
% the chroma (C) and the hue (H) in the Llab space.  
%
% SYNTAX
% ----------------------------------------------------------------------------
% LLABCH=xyz2llab(XYZS,XYZW,YW,YB,mo)
%
% XYZS = Relative tristimulus values of the samples.
%        For N colours, this is a Nx3 matrix.
%
% XYZW = Relative tristimulus values of the reference white.
%
% YW   = Luminance (cd/m2) of the reference white (1x1).
%
% YB   = Luminance factor of the background (1x1).
%
% mo   = Parameter describing the observation conditions:
%        m0=1.....reflection samples, average surround, field>4º
%	      m0=2.....reflection samples, average surround, field<4º
%   	   m0=3.....television and vdu, dim surround
%  	   m0=4.....cut-sheet transparency in dim surround
%	      m0=5.....35 mm projection transparency in dark surround
%
% LLABCH = [L a b C H(º)]. For N colours, this is a Nx3 matrix.
%
% RELATED FUNCTIONS
% ----------------------------------------------------------------------------
% llab2xyz
%

if mo==1
	D=1;
	Fs=3;
	Fl=0;
	Fc=1;
elseif mo==2
	D=1;
	Fs=3;
	Fl=1;
	Fc=1;
elseif mo==3
	D=0.7;
	Fs=3.5;
	Fl=1;
	Fc=1;
elseif mo==4
	D=1;
	Fs=5;
	Fl=1;
	Fc=1.1;
elseif mo==5
	D=0.7;
	Fs=4;
	Fl=1;
	Fc=1;
end

M=[0.8951 0.2664 -0.1614;-0.7502 1.7135 0.0367;0.0389 -0.0685 1.0296];
t=size(Ts);

% Matrices de respuesta de conos para cada uno de los trios de triestimulos
% Mor corresponde a los triest. del blanco de referencia bajo el iluminante
% de referencia: D65/2º

Mor=M*[95.05/100;1;108.88/100];
Mos=M*[Tos(1)/Tos(2);1;Tos(3)/Tos(2)];

for i=1:t(1)
	Ms(:,i)=(M*[Ts(i,1)/Ts(i,2);1;Ts(i,3)/Ts(i,2)]);
end
% Para que este ordenado colores por filas
Ms=Ms';

% Respuestas R G y B de la muestra bajo condiciones de referencia
b=(Mos(3)/Mor(3))^0.0834;
k=1;for i=1:t(1)
	R(k,1)=(D*Mor(1)/Mos(1)+1-D)*Ms(i,1);
	R(k,2)=(D*Mor(2)/Mos(2)+1-D)*Ms(i,2);

	if Ms(i,3)>=0
		R(k,3)=(D*Mor(3)/(Mos(3)^b)+1-D)*(Ms(i,3))^b;
	else
		R(k,3)=-(D*Mor(3)/(Mos(3)^b)+1-D)*(abs(Ms(i,3)))^b;
	end
	k=k+1;
end

% T= matriz de valores triestimulo de la muestra bajo condiciones de
% referencia, con los que vamos a trabajar en el espacio Llab

for i=1:t(1)
	T(:,i)= inv(M)*[R(i,1)*Ts(i,2);R(i,2)*Ts(i,2);R(i,3)*Ts(i,2)];
end
T=T';

% Empieza el calculo de coordenadas

z=1+Fl*(Ybs/100)^0.5;

for i=1:t(1)
	if T(i,1)/95.5>0.008856
		fx(i)=(T(i,1)/95.05)^(1/Fs);
	else	
		fx(i)=((0.008856^(1/Fs)-16/116)/0.008856)*(T(i,1)/95.05)+16/116;
	end

	if T(i,2)/100>0.008856
		fy(i)=(T(i,2)/100)^(1/Fs);
	else
		fy(i)=((0.008856^(1/Fs)-16/116)/0.008856)*(T(i,2)/100)+16/116;
	end

	if T(i,3)/108.88>0.008856
		fz(i)=(T(i,3)/108.88)^(1/Fs);
	else
		fz(i)=((0.008856^(1/Fs)-16/116)/0.008856)*(T(i,3)/108.88)+16/116;
	end
L(i)=116*(fy(i)^z)-16;
A(i)=500*(fx(i)-fy(i));
B(i)=200*(fy(i)-fz(i));
end

% Con estas cantidades se calculan las que van a ir en la formula 
% de diferencia de color

for i=1:t(1)
	C(i)=sqrt(A(i)^2+B(i)^2);
	Sc=1+0.47*log10(Ls)-0.057*(log10(Ls))^2;
%Cl(i)=(4.907+0.162*C(i)+10.92*log(0.638+0.07216*C(i)))*Fc*Sc;
	Sm(i)=0.7+0.02*L(i)-0.0002*L(i)^2;
	Ch(i)=25*log(1+0.05*C(i));
	Cl(i)=Ch(i)*Sm(i)*Fc*Sc;
% saturación: Sl(i)=Ch(i)/L(i)
	hl(i)=atan2(B(i),A(i));
	Al(i)=Cl(i)*cos(hl(i));
	Bl(i)=Cl(i)*sin(hl(i));
end
Llabch=[L;Al;Bl;Cl;hl*180/pi]';